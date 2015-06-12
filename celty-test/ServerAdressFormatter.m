//
//  ServerAdressFormatter.m
//  celty-test
//
//  Created by shdwprince on 6/12/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import "ServerAdressFormatter.h"

@implementation ServerAdressFormatter

- (NSString *) stringForObjectValue:(NSArray *)obj {
    if ([obj isKindOfClass:[NSArray class]]) {
        return [obj componentsJoinedByString:@":"];
    } else {
        return @"";
    }
}

- (BOOL)getObjectValue:(out id *)anObject
             forString:(NSString *)string
      errorDescription:(out NSString **)error {
    int i;
    for (i = (int) ([string length] == 0 ? 0 : [string length] - 1); i > 0; i--) {
        if ([string characterAtIndex:i] == ':') break;
    }

    if (i == 0) {
        *anObject = @[string]; // if I put string, @"100" here it's working fine
    } else {
        *anObject = @[[string substringToIndex:i], [string substringFromIndex:i+1]];
    }

    return YES;
}
@end
