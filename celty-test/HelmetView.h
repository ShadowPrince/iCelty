//
//  CeltyView.h
//  celty-test
//
//  Created by shdwprince on 6/12/15.
//  Copyright (c) 2015 shdwprince. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HelmetView : NSView
@property (readonly, strong) NSMutableDictionary *viewDict;

@property (readwrite, strong) NSArray *sizeConstraints;
@property (readwrite, weak) NSStackView *currentRow, *stackView;
@property (readwrite, assign) int totalTopOffset, ongoingTopOffset, ongoingLeftOffset, maxTopOffset, maxLeftOffset;

- (void) initCeltyObjects:(NSArray *)rows;
- (void) displayString:(NSString *)str;

@end
