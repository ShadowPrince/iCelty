//
//  CeltyButton.h
//  celty-test
//
//  Created by shdwprince on 6/12/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HelmetElement.h"

@interface HelmetButton : NSButton <HelmetElement>
@property (readonly, copy) NSString *command;
@property (readonly, copy) NSArray *requiredValues;

@property (readwrite, copy) NSMutableDictionary *args;

- (id) initWithName:(NSString *)_name
             command:(NSString *)_command
      requiredValues:(NSArray *)_requiredValues;

@end
