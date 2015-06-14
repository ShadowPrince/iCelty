//
//  HelmetDelegate.h
//  celty-test
//
//  Created by shdwprince on 6/14/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#ifndef celty_test_HelmetDelegate_h
#define celty_test_HelmetDelegate_h

@protocol HelmetDelegate <NSObject>
@optional
- (void) shouldSendCommand:(NSString *)cmd withArgs:(NSDictionary *)args;

@end

#endif
