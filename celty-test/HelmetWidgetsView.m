//
//  HelmetWidgetsView.m
//  celty-test
//
//  Created by shdwprince on 6/15/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "HelmetWidgetsView.h"

@implementation HelmetWidgetsView
@synthesize widgets;

- (instancetype) initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];

    widgets = [[NSMutableDictionary alloc] init];

    return self;
}

- (void) removeAllElements {
    widgets = [[NSMutableDictionary alloc] init];

    [self.views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeView:obj];
    }];
}

- (void) updateWidgetsWithDict:(NSDictionary *)data {
    [data enumerateKeysAndObjectsUsingBlock:^(id key, NSArray *widget, BOOL *stop) {
        HelmetWidget *w;
        if (!(w = [self.widgets objectForKey:key])) {
            w = [[HelmetWidget alloc] initWithTitle:key andText:@""];
            self.widgets[key] = w;
            [self addView:w inGravity:NSStackViewGravityLeading];
        }

        [w updateText:[widget componentsJoinedByString:@"\n"]];
    }];
}

@end
