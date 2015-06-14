//
//  Document.h
//  celty-test
//
//  Created by shdwprince on 6/11/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CeltyClient.h"
#import "Helmet.h"
#import "CeltyClientDelegate.h"

@interface Document : NSDocument <CeltyClientDelegate> {
    IBOutlet NSStackView *widgets;
    IBOutlet NSStackView *helmetView;
    IBOutlet NSProgressIndicator *connectionIndicator;
    IBOutlet NSTextField *connectionStatus;
}

@property (readwrite, copy) NSArray *serverAddress;
@property (readwrite, copy) NSString *token;
@property (readonly, strong) CeltyClient *cc;

- (IBAction)connect:(id)sender;
- (IBAction)mainMenu:(id)sender;
@end

