//
//  CeltyView.h
//  celty-test
//
//  Created by shdwprince on 6/12/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HelmetDelegate.h"

@interface Helmet : NSObject {
    struct {
        BOOL shouldSendCommand:YES;
    } delegateRespondsTo;
}
@property (nonatomic, weak) id <HelmetDelegate> delegate;

@property (readonly, strong) NSMutableDictionary *viewDict;

@property (readwrite, weak) NSStackView *view, *lastRow;

- (instancetype) initWithView:(NSStackView *)sv;
- (void) renderArray:(NSArray *)array;
- (void) displayString:(NSString *)str;

@end
