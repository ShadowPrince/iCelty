//
//  HelmetLabel.m
//  celty-test
//
//  Created by shdwprince on 6/13/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "HelmetLabel.h"

@implementation HelmetLabel
@synthesize name;


- (id) initWithName:(NSString *)_name
                text:(NSString *)_text {
    self = [super init];
    
    name = _name;

    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.stringValue = _text;
    self.drawsBackground = NO;
    self.bordered = NO;
    self.editable = NO;

    [self sizeToFit];
    
    return self;
}

@end
