//
//  CeltyClient.m
//  celty-test
//
//  Created by shdwprince on 6/13/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "CeltyClient.h"

@implementation CeltyClient
@synthesize serverAddress, token;
@synthesize widgets, widgetsView;
@synthesize helmet;
@synthesize delegate;

- (void) setDelegate:(id<CeltyClientDelegate>)_delegate {
    delegate = _delegate;

    delegateRespondsTo.didAuthenticated = [delegate respondsToSelector:@selector(didAuthenticated)];
    delegateRespondsTo.didFailedAuthenticating = [delegate respondsToSelector:@selector(didFailedReceivingMessage:)];
}

- (id) initWithServer:(id)_serverAddress
           helmetView:(NSStackView *)_helmetView
           widgetsView:(NSStackView *)_widgetsView
                token:(NSString *)_token {
    self = [super init];

    serverAddress = _serverAddress;
    widgetsView = _widgetsView;
    widgets = [[NSMutableDictionary alloc] init];
    token = _token;
    
    self.conn = [[CeltyConnection alloc] initWithServerAddress:_serverAddress];
    [self.conn setDelegate:self];
    [self.conn sendObject:@{@"token": self.token}];

    helmet = [[Helmet alloc] initWithView:_helmetView];
    [helmet setDelegate:self];

    [self.widgetsView.views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.widgetsView removeView:obj];
    }];
    return self;
}

- (void) didReceivedMessage:(NSDictionary *)msg {
    NSString *type = msg[@"type"];

    if ([type isEqualTo:@"auth"]) {
        if ([msg[@"result"] isEqualTo:@"success"]) {
            [self authenticated];
        } else {
            NSError *e = [[NSError alloc] initWithDomain:@"auth"
                                                    code:1
                                                userInfo:@{NSLocalizedDescriptionKey: msg[@"error"]}];
            [delegate didFailedAuthenticating:e];
        }
    } else if ([type isEqualTo:@"ui"]) {
        [self.helmet renderArray:msg[@"data"]];
    } else if ([type isEqualTo:@"ui_update"]) {
        [self.helmet updateByArray:msg[@"data"]];
    } else if ([type isEqualTo:@"widgets"]) {
        [self updateWidgetsWithDict:msg[@"data"]];
    }
}

- (void) shouldSendCommand:(NSString *)cmd withArgs:(id) args {
    [self.conn sendObject:@{@"command": cmd, @"args": args}];
}

- (void) updateWidgetsWithDict:(NSDictionary *)data {
    [data enumerateKeysAndObjectsUsingBlock:^(id key, NSArray *widget, BOOL *stop) {
        CeltyWidget *w;
        if (!(w = [self.widgets objectForKey:key])) {
            w = [[CeltyWidget alloc] initWithTitle:key andText:@""];
            self.widgets[key] = w;
            [self.widgetsView addView:w inGravity:NSStackViewGravityLeading];
        }

        [self.widgets[key] updateText:[widget componentsJoinedByString:@"\n"]];
    }];
}

- (void) authenticated {
    [delegate didAuthenticated];
    [self mainMenu];
    [self shouldSendCommand:@"celty:subscribe" withArgs:@[@"celty:widgets"]];
}

- (void) mainMenu {
    [self.conn sendObject:@{@"command": @"celty:main"}];
}

@end
