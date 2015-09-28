//
//  Event.m
//  TSTrackingKit
//
//  Created by Thomas Sillmann on 28.09.15.
//  Copyright © 2015 Thomas Sillmann. All rights reserved.
//

#import "TSEvent.h"

@implementation TSEvent

#pragma mark - Initializer

- (instancetype)initWithTitle:(NSString *)title {
    return [self initWithTitle:title andSubEventTitle:nil];
}

- (instancetype)initWithTitle:(NSString *)title andSubEventTitle:(NSString *)subEventTitle {
    self = [super init];
    if (self) {
        _title = title;
        _subEventTitle = subEventTitle;
    }
    return self;
}

#pragma mark - Methods

+ (TSEvent *)eventWithTitle:(NSString *)title {
    return [[TSEvent alloc] initWithTitle:title];
}

+ (TSEvent *)eventWithTitle:(NSString *)title andSubEventTitle:(NSString *)subEventTitle {
    return [[TSEvent alloc] initWithTitle:title andSubEventTitle:subEventTitle];
}

@end
