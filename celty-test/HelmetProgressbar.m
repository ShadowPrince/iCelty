//
//  HelmetProgressbar.m
//  celty-test
//
//  Created by shdwprince on 6/13/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "HelmetProgressbar.h"

@implementation HelmetProgressbar
@synthesize name;


- (id) initWithName:(NSString *)_name {
    self = [super initWithFrame:NSMakeRect(0, 0, 100, 20)];

    name = _name;
    [self setDoubleValue:50.0];
    [self displayIfNeeded];

    return self;
}

@end
