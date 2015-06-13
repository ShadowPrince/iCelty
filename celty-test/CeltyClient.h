//
//  CeltyClient.h
//  celty-test
//
//  Created by shdwprince on 6/13/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelmetView.h"

@interface CeltyClient : NSObject
@property (readonly, strong) NSArray *serverAddress;
@property (readonly, strong) HelmetView *helmetView;

- (id) initWithServer:(NSArray *)_serverAddress
        andHelmetView:(HelmetView *)_helmetView;

- (void) render;

@end
