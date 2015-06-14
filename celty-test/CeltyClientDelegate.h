//
//  CeltyClientDelegate.h
//  celty-test
//
//  Created by shdwprince on 6/14/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#ifndef celty_test_CeltyClientDelegate_h
#define celty_test_CeltyClientDelegate_h

@protocol CeltyClientDelegate <NSObject>
@optional
- (void) didAuthenticated;
- (void) didFailedAuthenticating:(NSError *)e;

@end

#endif
