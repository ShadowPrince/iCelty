//
//  HelmetProgressbar.h
//  celty-test
//
//  Created by shdwprince on 6/13/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HelmetElement.h"

@interface HelmetProgressbar : NSProgressIndicator <HelmetElement>

- (id) initWithName:(NSString *)_name;
@end
