//
//  CeltyWidget.h
//  celty-test
//
//  Created by shdwprince on 6/14/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HelmetLabel.h"

@interface CeltyWidget : NSStackView
@property (readonly, strong) HelmetLabel *title, *text;

- (instancetype) initWithTitle:(NSString *)_title
                       andText:(NSString *)_text;

- (void) updateText:(NSString *)text;

@end
