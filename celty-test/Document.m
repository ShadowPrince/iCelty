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
@synthesize serverAddress;
@synthesize cc;

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];

    cc = [[CeltyClient alloc] initWithServer:self.serverAddress andHelmetView:helmetView];
    self.serverAddress = @[@"127.0.0.1", @"80"];

    NSTextField *tf;
    for (int i = 0; i < 30; i++) {
        tf = [[NSTextField alloc] init];
        tf.stringValue = @"124";
        tf.translatesAutoresizingMaskIntoConstraints = NO;
        [widgets addView:tf inGravity:NSStackViewGravityLeading];
    }

    [widgets addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[m(1000)]"
                                                                    options:0 metrics:nil views:@{@"m": widgets}]];
    [widgets layout];
    NSLog(@"%f", tf.frame.size.height);

    /*
    widgets.translatesAutoresizingMaskIntoConstraints = NO;


    NSTextField *tf = [[NSTextField alloc] init];
    tf.translatesAutoresizingMaskIntoConstraints = NO;
    tf.bezeled = NO;
    tf.stringValue = @"124";
    [widgets addView:tf inGravity:NSStackViewGravityLeading];


    NSTextField *tf2 = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 20, 10, 10)];
    tf.translatesAutoresizingMaskIntoConstraints = NO;
    tf.bezeled = NO;
    tf.stringValue = @"123";
    [widgets addView:tf2 inGravity:NSStackViewGravityTop];
     */
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
