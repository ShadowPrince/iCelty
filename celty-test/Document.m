//
//  Document.m
//  celty-test
//
//  Created by shdwprince on 6/11/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "Document.h"

@interface Document ()

@end

@implementation Document
@synthesize serverAddress, token;
@synthesize cc;

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];

    connectionStatus.stringValue = @"";
    self.serverAddress = @[@"localhost", @"23590"];
    self.token = @"1";

    /*
    NSTextField *tf;
    for (int i = 0; i < 30; i++) {
        tf = [[NSTextField alloc] init];
        tf.stringValue = [[NSString alloc] initWithFormat:@"%d", i];
        tf.translatesAutoresizingMaskIntoConstraints = NO;
        [widgets addView:tf inGravity:NSStackViewGravityLeading];
    }
     */
}

- (void) connect:(id)sender {
    [connectionIndicator startAnimation:self];
    connectionStatus.stringValue = @"connecting";
    cc = [[CeltyClient alloc] initWithServer:self.serverAddress
                                  helmetView:helmetView
                                 widgetsView:widgets
                                       token:self.token];

    [cc setDelegate:self];
}

- (void) mainMenu:(id)sender {
    [self.cc mainMenu];
}

- (void) didAuthenticated {
    [connectionIndicator stopAnimation:self];
    connectionStatus.stringValue = @"";
}

- (void) didFailedAuthenticating:(NSError *)e {
    [connectionIndicator stopAnimation:self];
    connectionStatus.stringValue = [e localizedDescription];
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (NSString *)windowNibName {
    return @"Document";
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return YES;
}


- (void) setServerAddress:(NSArray *)_serverAddress {
    NSArray *address;
    if (_serverAddress == nil)
        address = @[];
    else
        address = [_serverAddress copy];

    if ([address count] == 1)
        address = [address arrayByAddingObjectsFromArray:@[@"8080"]];

    serverAddress = address;
}

@end
