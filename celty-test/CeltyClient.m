//
//  CeltyClient.m
//  celty-test
//
//  Created by shdwprince on 6/13/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "CeltyClient.h"

@implementation CeltyClient
@synthesize serverAddress;
@synthesize helmetView;

- (id) initWithServer:(id)_serverAddress
        andHelmetView:(HelmetView *)_helmetView {
    self = [super init];
    serverAddress = _serverAddress;
    helmetView = _helmetView;

    [self render];

    return self;
}

- (void) render {
    NSData *json = [[NSData alloc] initWithContentsOfFile:@"/Users/mc966/projects/ios/celty-test/celty-test/data/1.json"];
    NSError *e = nil;

    id object = [NSJSONSerialization
                  JSONObjectWithData:json options:0 error:&e];

    if ([object isKindOfClass:[NSArray class]]) {
        [self.helmetView initCeltyObjects:(NSArray *) object];
    } else {
        [self.helmetView displayString:[e localizedDescription]];
    }

}

@end
