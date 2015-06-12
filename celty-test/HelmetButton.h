//
//  CeltyButton.h
//  celty-test
//
//  Created by shdwprince on 6/12/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HelmetButton : NSButton
@property (readonly, copy) NSString *name;
@property (readonly, copy) NSString *command;
@property (readonly, strong) NSArray *requiredValues;

@property (readonly, strong) NSMutableDictionary *args;

- (id) initWithName:(NSString *)_name
             command:(NSString *)_command
      requiredValues:(NSArray *)_requiredValues;

@end
