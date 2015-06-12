//
//  CeltyInput.h
//  celty-test
//
//  Created by shdwprince on 6/12/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HelmetInput : NSTextField
@property (readonly, copy) NSString *name;

- (id) initWithName:(NSString *)_name;
@end
