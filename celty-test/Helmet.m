//
//  CeltyView.m
//  celty-test
//
//  Created by shdwprince on 6/12/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "Helmet.h"
#import "HelmetButton.h"
#import "HelmetInput.h"
#import "HelmetProgressbar.h"
#import "HelmetLabel.h"

@implementation Helmet
@synthesize viewDict;
@synthesize view, lastRow;
@synthesize delegate;

- (void) setDelegate:(id<HelmetDelegate>)_delegate {
    delegate = _delegate;

    delegateRespondsTo.shouldSendCommand = [delegate respondsToSelector:@selector(shouldSendCommand:withArgs:)];
}

- (instancetype) initWithView:(NSStackView *)sv {
    self = [super init];
    view = sv;

    return self;
}

- (void) renderArray:(NSArray *)array {
    viewDict = [[NSMutableDictionary alloc] init];
    for (NSView *v in [self.view views])
        [self.view removeView:v];

    [self lineBreak];
    for (NSArray *row in array) {
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
                [viewDict setObject:element[@"value"] forKey:element[@"name"]];
                [self addInput:i];
            }
        }

        [self lineBreak];
    }
    [self lineBreak];
}

- (void) addElement:(NSView *)e {
    e.translatesAutoresizingMaskIntoConstraints = NO;
    [self.lastRow addView:e inGravity:NSStackViewGravityLeading];
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
    [self.view addView:newRow inGravity:NSStackViewGravityLeading];

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
    [self.lastRow addView:[[HelmetLabel alloc] initWithName:@"1" text:str] inGravity:NSStackViewGravityTop];
}

@end
