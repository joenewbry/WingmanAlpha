#import <Foundation/Foundation.h>
#import <LookBack/GFSettingsViewController.h>

/** Public interface for Lookback.io, the UX testing tool. */
@interface LookBack : NSObject
/** In your applicationDidFinishLaunching: or similar, call this method to prepare
    Lookback for use, using the App Token from your integration guide at lookback.io.
*/
+ (void)setupWithAppToken:(NSString*)appToken;

/** Shared instance of LookBack to use from your code. You must call
    +[LookBack setupWithAppToken:] before calling this method. */
+ (LookBack*)lookback;

/** Whether Lookback is set to recording. You can either set this programmatically,
    or use GFSettingsViewController to let the user activate it. */
@property(nonatomic) BOOL enabled;

/** If enabled, displays UI to start recording when you shake the device. Default NO.
    
    This is just a convenience method. It's roughly equivalent to implementing
    -[motionEnded:withEvent:] in your first responder, and modally displaying a
    GFSettingsViewController on the window's root view controller.
*/
@property(nonatomic) BOOL shakeToRecord;

/** Is Lookback paused? Lookback will pause automatically when app is inactive.
    The value of this property is undefined if recording is not enabled (as there
    is nothing to pause) */
@property(nonatomic,getter=isPaused) BOOL paused;

/** Identifier for the user who's currently using the app. You can filter on
    this property at lookback.io later. If your service has log in user names,
    you can use that here. (optional) */
@property(nonatomic,copy) NSString *userIdentifier;

/** Track user navigation. Optional, and automatic if you don't use these methods
    manually. See README for more details.
    @param viewIdentifier Unique human readable identifier for a specific view
*/
- (void)enteredView:(NSString*)viewIdentifier;
- (void)exitedView:(NSString*)viewIdentifier;

// For debugging
@property(nonatomic,readonly) NSString *appToken;
@end

#pragma mark Settings

/** If you implement the method `+(NSString*)lookBackIdentifier` in your view controller, that view will automatically be logged under that name (and later filter on it at lookback.io). Otherwise, your view controller's class name will be used instead, with prefix ("UI") and suffix ("ViewController") removed. You can disable this behavior by setting the user default `GFAutomaticallyLogViewAppearance` to NO, and calling `-[LookBack enteredView:]` and `-[LookBack exitedView:]` methods manually.*/
extern NSString *const GFAutomaticallyLogViewAppearance;

/** Normally when you start a recording, it will be paused whenever the application becomes inactive (backgrounded or screen locked). If you record a very long experience, it will take a long time to upload, and be difficult to manage. In this case, you might want to enable the "Upload when inactive" option in Settings (or the GFAutosplitSettingsKey BOOL default). Then, recording will stop when the app is inactive, the short experience uploaded, and a new recording started anew when the app becomes active.*/
extern NSString *const GFAutosplitSettingsKey;

/** The BOOL default GFCameraEnabledSettingsKey controls whether the front-facing camera will record, in addition to recording the screen. */
extern NSString *const GFCameraEnabledSettingsKey;

/** The BOOL default GFAudioEnabledSettingsKey controls whether audio will be recorded together with the front-facing camera. Does nothing if GFCameraEnabledSettingsKey is NO. */
extern NSString *const GFAudioEnabledSettingsKey;

/** The BOOL default GFShowPreviewSettingsKey controls whether the user should be shown a preview image of their face at the bottom-right of the screen while recording, to make sure that they are holding their iPhone correctly and are well-framed. */
extern NSString *const GFShowPreviewSettingsKey;


/** When an experience upload starts, its URL is determined. You can then attach this URL to a bug report or similar.
    @example
        // Automatically put an experience's URL on the user's pasteboard when recording ends and upload starts.
        [[NSNotificationCenter defaultCenter] addObserverForName:GFStartedUploadingNotificationName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            NSDate *when = [note userInfo][GFExperienceStartedAtUserInfoKey];
            if(fabs([when timeIntervalSinceNow]) < 60) { // Only if it's for an experience we just recorded
                NSURL *url = [note userInfo][GFExperienceDestinationURLUserInfoKey];
                [UIPasteboard generalPasteboard].URL = url;
            }
        }];
*/
extern NSString *const GFStartedUploadingNotificationName;

/** UserInfo key in a GFStartedUploadingNotificationName notification. The value is an NSURL that the user can visit
    on a computer to view the experience he/she just recorded. */
extern NSString *const GFExperienceDestinationURLUserInfoKey;

/** UserInfo key in a GFStartedUploadingNotificationName notification. The value is an NSDate of when the given experience
    was recorded (so you can correlate the upload with the recording). */
extern NSString *const GFExperienceStartedAtUserInfoKey;
