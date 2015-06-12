//
//  ServerAdressFormatter.h
//  celty-test
//
//  Created by shdwprince on 6/12/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerAdressFormatter : NSFormatter
- (NSString *) stringForObjectValue:(NSArray *)obj;

- (BOOL)getObjectValue:(out id *)anObject
             forString:(NSString *)string
      errorDescription:(out NSString **)error;
@end
