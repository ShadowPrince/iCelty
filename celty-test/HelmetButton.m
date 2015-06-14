//
//  CeltyButton.m
//  celty-test
//
//  Created by shdwprince on 6/12/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "HelmetButton.h"

@implementation HelmetButton
@synthesize name;
@synthesize command;
@synthesize requiredValues;

@synthesize args;

- (id) initWithName:(NSString *)_name
             command:(NSString *)_command
      requiredValues:(NSArray *)_requiredValues {

    self = [super init];
    
    name = [_name copy];
    command = [_command copy];
    requiredValues = [_requiredValues copy];

    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.bezelStyle = NSPushOnPushOffButton;
    self.args = [[NSMutableDictionary alloc] init];

    return self;
}

@end
