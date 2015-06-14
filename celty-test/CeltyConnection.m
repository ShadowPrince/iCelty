//
//  CeltyConnection.m
//  celty-test
//
//  Created by shdwprince on 6/13/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "CeltyConnection.h"
#import "CeltyConnectionDelegate.h"

@implementation CeltyConnection
@synthesize client, buffer;
@synthesize responsesPoll;
@synthesize delegate;

- (void) setDelegate:(id<CeltyConnectionDelegate>)_delegate {
    delegate = _delegate;

    delegateRespondsTo.didFailedReceivingMessage = [delegate respondsToSelector:@selector(didFailedReceivingMessage:)];
    delegateRespondsTo.didReceivedMessage = [delegate respondsToSelector:@selector(didReceivedMessage:)];
}

- (instancetype) initWithServerAddress:(NSArray *)serverAddress {
    self = [super init];

    self.buffer = [[NSMutableString alloc] init];
    responsesPoll = [[NSMutableArray alloc] init];

    client = [[FastSocket alloc] initWithHost:@"localhost" andPort:@"23590"];
    if (![client connect]) {
        NSLog(@"Connection failed");
    } else {
        [NSThread detachNewThreadSelector:@selector(networkLoop) toTarget:self withObject:nil];
        [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(actionsLoop) userInfo:nil repeats:YES];
    }
    return self;
}

- (void) networkLoop {
    long length = 10, received = 0;
    char buff[length];

    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(test) userInfo:nil repeats:NO];

    while (true) {
        if ((received = [client receiveBytes:buff limit:length]) > 0) {
            [self.buffer appendString:[[NSString alloc] initWithBytes:buff length:received encoding:NSUTF8StringEncoding]];

            NSMutableArray *lines = [[self.buffer componentsSeparatedByString:@"\r\n"] mutableCopy];
            if ([lines count] > 1) {
                self.buffer = [[lines lastObject] mutableCopy];
                [lines removeLastObject];

                @synchronized(self.responsesPoll) {
                    [self.responsesPoll addObjectsFromArray:lines];
                }
            }
        }
    }
}

- (void) actionsLoop {
    @synchronized(self.responsesPoll) {
        for (NSString *line in self.responsesPoll)
            [self processInput:line];

        [self.responsesPoll removeAllObjects];
    }
}

- (void) processInput:(NSString *)line {
    NSError *e;
    if (delegateRespondsTo.didReceivedMessage) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[line dataUsingEncoding:NSUTF8StringEncoding]
                                                             options:0
                                                               error:&e];
        if (e && delegateRespondsTo.didFailedReceivingMessage)
            [delegate didFailedReceivingMessage:e];
        else
            [delegate didReceivedMessage:data];
    }
}

- (void) sendObject:(id)object {
    NSError *e;
    NSData *d = [NSJSONSerialization dataWithJSONObject:object
                                                options:0
                                                  error:&e];

    if (e) {
        NSLog(@"%@", e); //@TODO: raise shit
    }

    NSString *strd = [[[NSString alloc] initWithData:d
                                            encoding:NSUTF8StringEncoding]
                      stringByAppendingString:@"\r\n"];

    d = [strd dataUsingEncoding:NSUTF8StringEncoding];
    [client sendBytes:[d bytes] count:[d length]];
}

@end
