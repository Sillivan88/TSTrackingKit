//
//  Event.h
//  TSTrackingKit
//
//  Created by Thomas Sillmann on 28.09.15.
//  Copyright © 2015 Thomas Sillmann. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The @c TSEvent class is used to describe an event which can be posted to a Tracking file by using the @c TSTracking class.
 */
@interface TSEvent : NSObject

/**
 The title of the event.
 */
@property (strong, readonly, nonatomic) NSString *title;

/**
 The optional title of an sub event for the given event.
 */
@property (strong, readonly, nonatomic) NSString *subEventTitle;

/**
 Initializer to create a new @c TSEvent instance with the given title. @c subEventTitle will be set to nil.
 @param title The title of the new instantiated event.
 @return New @c TSEvent instance with the given title.
 */
- (instancetype)initWithTitle:(NSString *)title;

/**
 Initializer to create a new @c TSEvent instance with the given title and sub event title.
 @param title The title of the new instantiated event.
 @param subEventTitle The title for the sub event of the event.
 @return New @c TSEvent instance with the given title and sub title.
 */
- (instancetype)initWithTitle:(NSString *)title andSubEventTitle:(NSString *)subEventTitle;

/**
 Class method to create a new @c TSEvent instance with the given title. @c subEventTitle will be set to nil.
 @param title The title of the new instantiated event.
 @return New @c TSEvent instance with the given title.
 */
+ (TSEvent *)eventWithTitle:(NSString *)title;

/**
 Class method to create a new @c TSEvent instance with the given title and sub event title.
 @param title The title of the new instantiated event.
 @param subEventTitle The title for the sub event of the event.
 @return New @c TSEvent instance with the given title and sub title.
 */
+ (TSEvent *)eventWithTitle:(NSString *)title andSubEventTitle:(NSString *)subEventTitle;

@end
