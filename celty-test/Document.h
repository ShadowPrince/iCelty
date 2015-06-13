//
//  Document.h
//  celty-test
//
//  Created by shdwprince on 6/11/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CeltyClient.h"
#import "HelmetView.h"

@interface Document : NSDocument {
    IBOutlet NSStackView *widgets;
    IBOutlet HelmetView *helmetView;
}

@property (readonly, copy) NSArray *serverAddress;
@property (readonly, strong) CeltyClient *cc;

@end

