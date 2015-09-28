//
//  Tracking.h
//  TSTrackingKit
//
//  Created by Thomas Sillmann on 28.09.15.
//  Copyright © 2015 Thomas Sillmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSEvent;

/**
 The @c TSTracking class is used to log certain events of an app together with several information within an appropriate tracking file.
 */
@interface TSTracking : NSObject

/**
 The URL to the tracking file within the file system. By default, the tracking file is written into the documents directory and is namend "Tracking.txt". If this property is set to a new value, the framework will check if already a file called "Tracking.txt" exists in the previous location. If so, the existing file will be moved to the new location.
 */
@property (strong, nonatomic) NSURL *trackingFileURL;

/**
 Returns a shared @c TSTracking object instance.
 @return The singleton instance of the @c TSTracking class.
 */
+ (TSTracking *)sharedTracking;

/**
 Writes the information about the given event into the tracking file using the current timestamp and other local information.
 @param event The event which has to be posted within the tracking file.
 */
- (void)postEvent:(TSEvent *)event;

/**
 Writes the information about the given event into the tracking file using the current timestamp and other local information. Optional additional information will be posted for this tracking after the default information, followed by the event.
 @param additionInfo Optional addition information which will be posted together with the other information for this tracking entry.
 @param event The event which has to be posted within the tracking file.
 */
- (void)postInformation:(NSString *)additionalInfo forEvent:(TSEvent *)event;

@end
