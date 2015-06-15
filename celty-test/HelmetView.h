//
//  CeltyView.h
//  celty-test
//
//  Created by shdwprince on 6/12/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HelmetDelegate.h"
#import "FlippedStackView.h"

@interface HelmetView : FlippedStackView {
    struct {
        BOOL shouldSendCommand:YES;
    } delegateRespondsTo;
}
@property (nonatomic, weak) id <HelmetDelegate> delegate;

@property (readonly, strong) NSMutableDictionary *viewDict;
@property (readonly, strong) NSMutableDictionary *elements;

@property (readwrite, weak) NSStackView *lastRow;

- (void) renderArray:(NSArray *)array;
- (void) updateByArray:(NSDictionary *) data;
- (void) removeAllElements;
- (void) displayString:(NSString *)str;

@end
