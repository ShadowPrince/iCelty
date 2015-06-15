//
//  CeltyClient.h
//  celty-test
//
//  Created by shdwprince on 6/13/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelmetView.h"
#import "CeltyConnection.h"
#import "CeltyClientDelegate.h"
#import "HelmetWidgetsView.h"

@interface CeltyClient : NSObject <CeltyConnectionDelegate, HelmetDelegate> {
    struct {
        BOOL didConnected:YES;
        BOOL didFailedConnecting:YES;
        BOOL didAuthenticated:YES;
        BOOL didFailedAuthenticating:YES;

    } delegateRespondsTo;
}
@property (nonatomic, weak) id <CeltyClientDelegate> delegate;

@property (readwrite, strong) CeltyConnection *conn;
@property (readonly, strong) NSArray *serverAddress;
@property (readwrite, copy) NSString *token;

@property (readonly, weak) HelmetWidgetsView *widgetsView;
@property (readonly, strong) HelmetView *helmet;

- (id) initWithServer:(NSArray *)_serverAddress
           helmetView:(HelmetView *)_helmetView
          widgetsView:(HelmetWidgetsView *)_widgetsView
                token:(NSString *)_token;

- (void) mainMenu;

@end
