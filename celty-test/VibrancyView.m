//
//  VibrancyView.m
//  celty-test
//
//  Created by shdwprince on 6/14/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "VibrancyView.h"

@implementation VibrancyView

- (instancetype) initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    self.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantDark];
    return self;
}

@end
