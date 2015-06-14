//
//  CeltyWidget.m
//  celty-test
//
//  Created by shdwprince on 6/14/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "CeltyWidget.h"

@implementation CeltyWidget
@synthesize title, text;

- (instancetype) initWithTitle:(NSString *)_title
                       andText:(NSString *)_text {
    self = [super init];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.orientation = NSUserInterfaceLayoutOrientationVertical;
    self.alignment = NSAlignMinXNearest;
    self.spacing = 0.0;

    title = [[HelmetLabel alloc] initWithName:@"" text:_title];
    text = [[HelmetLabel alloc] initWithName:@"" text:_text];

    [self addView:self.title inGravity:NSStackViewGravityLeading];
    [self addView:self.text inGravity:NSStackViewGravityLeading];

    return self;
}

- (void) drawRect:(NSRect)dirtyRect {
    [[NSColor controlColor] set];

//    [NSBezierPath fillRect:dirtyRect];
}

- (void) updateText:(NSString *)_text {
    self.text.stringValue = _text;
}

@end
