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


- (id) initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];

    self.sizeConstraints = @[];
    viewDict = [[NSMutableDictionary alloc] initWithDictionary:@{@"input-two": @"FOO",
                                                                 @"input-three": @"BAR", }];

    [self initCeltyObjects];

    return self;
}

- (id) initWithObject:(id *)object {
    self = [super initWithCoder:nil];

    return self;
}

- (void) initCeltyObjects {
    HelmetButton *b = [[HelmetButton alloc] initWithName:@"button-one"
                                                  command:@"submit"
                                           requiredValues:@[@"input-two", @"input-three"]];
    b.title = @"button-one";
    [b.args setValue:@"foo"forKey:@"bar"];

    [self addElement:[[HelmetLabel alloc] initWithName:@"label-one"
                                                  text:@"TEXT"]];
    [self addButton:b];

    [self addInput:[[HelmetInput alloc] initWithName:@"input-two"]
         lineBreak:YES];
    [self addInput:[[HelmetInput alloc] initWithName:@"input-three"]];

    [self addElement:[[HelmetProgressbar alloc] initWithName:@"progressbar"]
           lineBreak:YES];
}

- (void) updateConstraints {
    [super updateConstraints];

    if (self.maxTopOffset < self.totalTopOffset + self.ongoingTopOffset)
        self.maxTopOffset = self.totalTopOffset + self.ongoingTopOffset;

    if (self.maxLeftOffset < self.ongoingLeftOffset)
        self.maxLeftOffset = self.ongoingLeftOffset;

    [self removeConstraints:self.sizeConstraints];

    self.sizeConstraints = [[NSLayoutConstraint constraintsWithVisualFormat:[[NSString alloc] initWithFormat:@"V:[x(%d)]", self.maxTopOffset]
                                                                    options:NSLayoutFormatAlignAllCenterY
                                                                    metrics:@{}
                                                                      views:@{@"x": self}]
                            arrayByAddingObjectsFromArray:
                            [NSLayoutConstraint constraintsWithVisualFormat:[[NSString alloc] initWithFormat:@"[x(%d)]", self.maxLeftOffset]
                                                                    options:NSLayoutFormatAlignAllCenterX
                                                                    metrics:@{}
                                                                      views:@{@"x": self}]];
    [self addConstraints:self.sizeConstraints];
}

- (void) addElement:(NSView *)e lineBreak:(BOOL)lb {
    if (lb) {
        self.ongoingLeftOffset = 0;
        self.totalTopOffset += self.ongoingTopOffset;
        self.ongoingTopOffset = 0;
    }

    [e setFrameOrigin:NSMakePoint(self.ongoingLeftOffset, self.totalTopOffset)];
    [self addSubview:e];

    self.ongoingLeftOffset += e.frame.size.width;
    if (self.ongoingTopOffset < e.frame.size.height) {
        self.ongoingTopOffset = e.frame.size.height;
    }

    [self updateConstraints];
}

- (void) addButton:(HelmetButton *)b lineBreak:(BOOL)lb {
    b.target = self;
    b.action = @selector(buttonSubmit:);
    [self addElement:b lineBreak:lb];
}

- (void) addInput:(HelmetInput *)input lineBreak:(BOOL)lb {
    [input bind:@"value" toObject:self.viewDict withKeyPath:input.name options:nil];
    [self addElement:input lineBreak:lb];
}


- (void) addElement:(NSView *)e {
    [self addElement:e lineBreak:NO];
}

- (void) addInput:(HelmetInput *)input {
    [self addInput:input lineBreak:NO];
}

- (void) addButton:(HelmetButton *)b {
    [self addButton:b lineBreak:NO];
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


- (BOOL) isFlipped {
    return YES;
}

@end
