//
//  CeltyInput.m
//  celty-test
//
//  Created by shdwprince on 6/12/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "HelmetInput.h"

@implementation HelmetInput
@synthesize name;


// @TODO: make it multi-line by \n
- (id) initWithName:(NSString *)_name {
    self = [super init];

    name = _name;
    self.translatesAutoresizingMaskIntoConstraints = NO;

    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"[x(100)]"
                                             options:0
                                             metrics:nil
                                               views:@{@"x": self}]];
    return self;
}

@end
