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
@synthesize client;
@synthesize responsesPoll;
@synthesize delegate;

- (void) setDelegate:(id<CeltyConnectionDelegate>)_delegate {
    delegate = _delegate;

    delegateRespondsTo.didFailedReceivingMessage = [delegate respondsToSelector:@selector(didFailedReceivingMessage:)];
    delegateRespondsTo.didReceivedMessage = [delegate respondsToSelector:@selector(didReceivedMessage:)];
}

- (instancetype) initWithServerAddress:(NSArray *)serverAddress {
    self = [super init];

    responsesPoll = [[NSMutableArray alloc] init];

    client = [[FastSocket alloc] initWithHost:@"localhost" andPort:@"23590"];
    self.run = YES;

    if (![client connect]) {
        NSLog(@"Connection failed");
    } else {
        [NSThread detachNewThreadSelector:@selector(networkLoop) toTarget:self withObject:nil];
        [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(actionsLoop) userInfo:nil repeats:YES];
    }
    return self;
}

- (void) networkLoop {
    @autoreleasepool {
        long length = 1024, received = 0;
        char buff[length];
        NSMutableString *buffer = [[NSMutableString alloc] init];

        while (self.run) {
            @autoreleasepool {
                if ((received = [client receiveBytes:buff limit:length]) > 0) {
                    [buffer appendString:[[NSString alloc] initWithBytes:buff length:received encoding:NSUTF8StringEncoding]];
                    NSMutableArray *lines = [[buffer componentsSeparatedByString:@"\r\n"] mutableCopy];

                    if ([lines count] > 1) {
                        [buffer setString:[lines lastObject]];
                        [lines removeLastObject];

                        @synchronized(self.responsesPoll) {
                            [self.responsesPoll addObjectsFromArray:lines];
                        }
                    }
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
        NSLog(@"%@", e); //@TODO: error reporting
    }

    NSString *strd = [[[NSString alloc] initWithData:d
                                            encoding:NSUTF8StringEncoding]
                      stringByAppendingString:@"\r\n"];

    d = [strd dataUsingEncoding:NSUTF8StringEncoding];
    [client sendBytes:[d bytes] count:[d length]];
}

- (void) close {
    self.run = NO;
    [self.client close];
}

@end
