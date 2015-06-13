//
//  CeltyView.m
//  celty-test
//
//  Created by shdwprince on 6/12/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "HelmetView.h"
#import "HelmetButton.h"
#import "HelmetInput.h"
#import "HelmetProgressbar.h"
#import "HelmetLabel.h"

@implementation HelmetView
@synthesize viewDict;
@synthesize totalTopOffset, ongoingTopOffset, ongoingLeftOffset;
@synthesize stackView, currentRow;

- (void) initCeltyObjects:(NSArray *)rows {
    NSStackView *_stackView = [[NSStackView alloc] init];
    self.stackView = _stackView;

    [self.stackView setOrientation:NSUserInterfaceLayoutOrientationVertical];
    [self.stackView setAlignment:NSLayoutAttributeLeading];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.stackView];
    [self lineBreak];

    self.sizeConstraints = @[];
    self.maxLeftOffset = 0;
    self.maxTopOffset = 0;
    viewDict = [[NSMutableDictionary alloc] initWithDictionary:@{@"input-two": @"FOO",
                                                                 @"input-three": @"BAR", }];
    for (NSArray *row in rows) {
        for (NSDictionary *element in row) {
            NSString *type = element[@"type"];
            if ([type isEqualToString:@"button"]) {
                HelmetButton *b = [[HelmetButton alloc] initWithName:element[@"name"]
                                                         command:element[@"command"]
                                                  requiredValues:element[@"grab"]];
                b.args = element[@"args"];
                b.title = element[@"caption"];
                [self addButton:b];
            } else if ([type isEqualToString:@"label"]) {
                HelmetLabel *l = [[HelmetLabel alloc] initWithName:element[@"name"]
                                                              text:element[@"text"]];
                [self addElement:l];
            } else if ([type isEqualToString:@"input"]) {
                HelmetInput *i = [[HelmetInput alloc] initWithName:element[@"name"]];
                i.stringValue = element[@"value"];

                [self addInput:i];
            }
        }

        [self lineBreak];
    }
    [self lineBreak];
}

- (void) updateConstraints {
    [super updateConstraints];

    [self removeConstraints:self.sizeConstraints];
    self.sizeConstraints = [[NSLayoutConstraint constraintsWithVisualFormat:[[NSString alloc] initWithFormat:@"V:[x(%d)]", 1000]
                                                                    options:NSLayoutFormatAlignAllCenterY
                                                                    metrics:@{}
                                                                      views:@{@"x": self}]
                            arrayByAddingObjectsFromArray:
                            [NSLayoutConstraint constraintsWithVisualFormat:[[NSString alloc] initWithFormat:@"[x(%d)]", 1000]
                                                                    options:NSLayoutFormatAlignAllCenterX
                                                                    metrics:@{}
                                                                      views:@{@"x": self}]];
    [self addConstraints:self.sizeConstraints];
}

- (void) addElement:(NSView *)e {
    [e setFrameOrigin:NSMakePoint(self.ongoingLeftOffset, self.totalTopOffset)];
    e.translatesAutoresizingMaskIntoConstraints = NO;
    [self.currentRow addView:e inGravity:NSStackViewGravityLeading];

    [self updateConstraints];
}

- (void) addButton:(HelmetButton *)b {
    b.target = self;
    b.action = @selector(buttonSubmit:);
    [self addElement:b];
}

- (void) addInput:(HelmetInput *)input {
    [input bind:@"value" toObject:self.viewDict withKeyPath:input.name options:nil];
    [self addElement:input];
}

- (void) lineBreak {
    NSStackView *newRow = [[NSStackView alloc] init];
    newRow.translatesAutoresizingMaskIntoConstraints = NO;
    [newRow setOrientation:NSUserInterfaceLayoutOrientationHorizontal];
    [self.stackView addView:newRow inGravity:NSStackViewGravityLeading];

    self.currentRow = newRow;
}

- (void) buttonSubmit:(HelmetButton *) sender{
    NSMutableDictionary *args = [[NSMutableDictionary alloc] initWithDictionary:sender.args];

    for (NSString *k in sender.requiredValues) {
        if ([viewDict objectForKey:k] == nil) {
            [args setValue:@"" forKey:k];
        } else {
            [args setValue:[viewDict objectForKey:k] forKey:k];
        }
    }

    NSLog(@"Celty call: %@(%@)", sender.command, args);
    /* Proceed to send sender.command with values
     */
}

- (void) displayString:(NSString *)str {
    [self addElement:[[HelmetLabel alloc] initWithName:@"string" text:str]];
}


- (BOOL) isFlipped {
    return YES;
}

- (void) drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    [[NSColor greenColor] set];
    [NSBezierPath fillRect:dirtyRect];
}

@end
