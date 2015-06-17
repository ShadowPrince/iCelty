//
//  CeltyConnection.h
//  celty-test
//
//  Created by shdwprince on 6/13/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FastSocket.h"
#import "CeltyConnectionDelegate.h"

@interface CeltyConnection : NSObject <CeltyConnectionDelegate> {
    struct {
        BOOL didReceivedMessage:YES;
        BOOL didFailedReceivingMessage:YES;

    } delegateRespondsTo;
}
@property (nonatomic, weak) id <CeltyConnectionDelegate> delegate;

@property (readonly, strong) FastSocket *client;

@property (readwrite, atomic) BOOL run;
@property (readonly, strong) NSMutableArray *responsesPoll;


- (instancetype) initWithServerAddress:(NSArray *)serverAddress;
- (void) setDelegate:(id<CeltyConnectionDelegate>)delegate;

- (void) sendObject:(id)object;
- (void) close;

@end
