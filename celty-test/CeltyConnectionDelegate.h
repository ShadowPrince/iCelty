//
//  CeltyConnectionDelegate.h
//  celty-test
//
//  Created by shdwprince on 6/14/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#ifndef celty_test_CeltyConnectionDelegate_h
#define celty_test_CeltyConnectionDelegate_h

@protocol CeltyConnectionDelegate <NSObject>

@optional
- (void) didFailedReceivingMessage:(NSError *)e;
- (void) didReceivedMessage:(NSDictionary *)msg;

@end

#endif
