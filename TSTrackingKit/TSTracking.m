//
//  Tracking.m
//  TSTrackingKit
//
//  Created by Thomas Sillmann on 28.09.15.
//  Copyright © 2015 Thomas Sillmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSTracking.h"
#import "TSEvent.h"

@interface TSTracking ()

/**
 Returns a complete entry for tracking. It uses the given additional information as well as an event to create an appropriate string.
 @param additionInfo Optional additional information which can be posted together with the tracking information.
 @param event The event for a tracking entry.
 @return A formatted string including all relevent tracking information.
 */
- (NSString *)trackingStringForInformation:(NSString *)additionalInfo forEvent:(TSEvent *)event;

/**
 Returns the general information for every tracking entry. This information include the current timestamp, the iOS version and the app version.
 @return A formatted string including all general information for a tracking entry.
 */
- (NSString *)generalTrackingInformation;

/**
 Returns a formatted string including the information of a given @c TSEvent object.
 @param event The event which information should be returned within a formatted string.
 @return A formatted string including the information of the given @c TSEvent object.
 */
- (NSString *)eventTrackingInformationForEvent:(TSEvent *)event;

@end

@implementation TSTracking

@synthesize trackingFileURL = _trackingFileURL;

#pragma mark - Properties

- (NSURL *)trackingFileURL {
    if (!_trackingFileURL) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
        _trackingFileURL = [documentsDirectoryURL URLByAppendingPathComponent:@"Tracking.txt"];
    }
    return _trackingFileURL;
}

- (void)setTrackingFileURL:(NSURL *)trackingFileURL {
    if (_trackingFileURL == trackingFileURL) return;
    if ([[NSFileManager defaultManager] fileExistsAtPath:_trackingFileURL.path]) {
        [[NSFileManager defaultManager] moveItemAtURL:_trackingFileURL toURL:trackingFileURL error:nil];
    }
    _trackingFileURL = trackingFileURL;
}

#pragma mark - Methods

+ (TSTracking *)sharedTracking {
    static TSTracking *sharedTracking;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTracking = [[TSTracking alloc] init];
    });
    return sharedTracking;
}

- (void)postEvent:(TSEvent *)event {
    [self postInformation:nil forEvent:event];
}

- (void)postInformation:(NSString *)additionalInfo forEvent:(TSEvent *)event {
    NSString *trackingString = [self trackingStringForInformation:additionalInfo forEvent:event];
    [trackingString writeToURL:self.trackingFileURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (NSString *)trackingStringForInformation:(NSString *)additionalInfo forEvent:(TSEvent *)event {
    if ([additionalInfo isEqualToString:@""] || additionalInfo == nil) {
        return [NSString stringWithFormat:@"%@ | %@", [self generalTrackingInformation], [self eventTrackingInformationForEvent:event]];
    }
    return [NSString stringWithFormat:@"%@ | %@ | %@", [self generalTrackingInformation], additionalInfo, [self eventTrackingInformationForEvent:event]];
}

- (NSString *)generalTrackingInformation {
    NSDate *currentTimestamp = [NSDate date];
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    NSString *appVersion = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"%@; iOS %@; App version %@", currentTimestamp, systemVersion, appVersion];
}

- (NSString *)eventTrackingInformationForEvent:(TSEvent *)event {
    if (event.subEventTitle == nil) {
        return event.title;
    }
    return [NSString stringWithFormat:@"%@ -> %@", event.title, event.subEventTitle];
}

@end
