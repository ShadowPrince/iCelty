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
@synthesize delegate;
@synthesize viewDict, elements;
@synthesize lastRow;

- (void) setDelegate:(id<HelmetDelegate>)_delegate {
    delegate = _delegate;

    delegateRespondsTo.shouldSendCommand = [delegate respondsToSelector:@selector(shouldSendCommand:withArgs:)];
}

- (void) removeAllElements {
    viewDict = [[NSMutableDictionary alloc] init];
    elements = [[NSMutableDictionary alloc] init];

    for (NSView *v in [self views])
        [self removeView:v];

    [self lineBreak];
}

- (void) renderArray:(NSArray *)array {
    [self removeAllElements];

    for (NSArray *row in array) {
        for (NSDictionary *element in row) {
            NSString *type = element[@"type"];
            NSString *name = element[@"name"];
            if (name == nil)
                name = @"unnamed";

            if ([type isEqualToString:@"button"]) {
                HelmetButton *b = [[HelmetButton alloc] initWithName:name
                                                         command:element[@"command"]
                                                  requiredValues:element[@"grab"]];
                b.args = element[@"args"];
                b.title = element[@"caption"];
                [self addButton:b];
            } else if ([type isEqualToString:@"label"]) {
                HelmetLabel *l = [[HelmetLabel alloc] initWithName:name
                                                              text:element[@"text"]];
                [self addElement:l];
            } else if ([type isEqualToString:@"input"]) {
                HelmetInput *i = [[HelmetInput alloc] initWithName:name];
                [viewDict setObject:element[@"value"] forKey:element[@"name"]];
                [self addInput:i];
            }
        }

        [self lineBreak];
    }
    [self lineBreak];
}

- (void) updateByArray:(NSDictionary *) data {
    NSArray *keyPairs = @[
                          @[@"text", @"stringValue"],
                          @[@"caption", @"title"]
                          ];

    for (NSString *key in [data allKeys]) {
        NSMutableDictionary *values = [[data objectForKey:key] mutableCopy];
        NSView <HelmetElement> *el = [self.elements objectForKey:key];
        NSString *class = [el className];

        if (el) {
            int method = 0;
            if (values[@"__method"]) {
                method = 1;
                [values removeObjectForKey:@"__method"];
            }

            for (NSString *key in [values allKeys]) {
                id object = [values objectForKey:key];

                if ([class isEqualTo:@"HelmetInput"] && [key isEqualTo:@"value"]) {
                    [viewDict setObject:object forKey:[el name]];
                } else {
                    NSString *newKey = key;
                    for (NSArray *pair in keyPairs)
                        if ([pair[0] isEqualTo:key]) {
                            newKey = pair[1];
                            break;
                        }

                    if (method == 0) {
                        [el setValue:object forKey:newKey];
                    } else if (method == 1) {
                        [el setValue:[[el valueForKey:newKey] stringByAppendingString:object ] forKey:newKey];
                    }
                }
            }
        }
    }
}

- (void) addElement:(NSView <HelmetElement> *)e {
    [self.elements setObject:e forKey:e.name];
    [self.lastRow addView:e inGravity:NSStackViewGravityLeading];
}

- (void) addButton:(HelmetButton *)b {
    b.target = self;
    b.action = @selector(buttonSubmit:);
    [self addElement:b];
}

- (void) addInput:(HelmetInput *)input {
    [input bind:@"value" toObject:self.viewDict withKeyPath:input.name options:@{NSContinuouslyUpdatesValueBindingOption: @YES}];
    [self addElement:input];
}

- (void) lineBreak {
    NSStackView *newRow = [[NSStackView alloc] init];
    newRow.translatesAutoresizingMaskIntoConstraints = NO;
    [newRow setOrientation:NSUserInterfaceLayoutOrientationHorizontal];
    [self addView:newRow inGravity:NSStackViewGravityLeading];

    self.lastRow = newRow;
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

    [self.delegate shouldSendCommand:sender.command withArgs:args];
}

- (void) displayString:(NSString *)str {
    [self removeAllElements];
    [self.lastRow addView:[[HelmetLabel alloc] initWithName:@"1" text:str] inGravity:NSStackViewGravityTop];
}

@end
