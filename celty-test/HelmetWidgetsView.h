//
//  HelmetWidgetsView.h
//  celty-test
//
//  Created by shdwprince on 6/15/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FlippedStackView.h"
#import "HelmetWidget.h"

@interface HelmetWidgetsView : FlippedStackView
@property (readonly, strong) NSMutableDictionary *widgets;

- (void) removeAllElements;
- (void) updateWidgetsWithDict:(NSDictionary *)data;

@end
