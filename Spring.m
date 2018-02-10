#import <objc/runtime.h>
#import "DTShared.h"

#ifdef BuildForiPhoneX
#define kStatusBarTimeKey "_shortTimeItemDateFormatter"
#else
#define kStatusBarTimeKey "_timeItemDateFormatter"
#endif

@interface SBStatusBarStateAggregator : NSObject
+ (instancetype)sharedInstance;
- (void)_updateTimeItems;
@end

static BOOL showDate;

static __attribute__((constructor)) void springboardDateTapListener() {
    int regToken;
    notify_register_dispatch(kPostNotifToggleKey, &regToken, dispatch_get_main_queue(), ^(int token) {
        showDate = !showDate;
        
        SBStatusBarStateAggregator *sbsa = [objc_getClass("SBStatusBarStateAggregator") sharedInstance];
        
        NSDateFormatter *timeFormat = [sbsa valueForKey:@kStatusBarTimeKey];
        
        timeFormat.dateStyle = showDate;
        timeFormat.timeStyle = !showDate;
        
#ifdef BuildForiPhoneX
        // figure out how to trigger time update on iPhone X
#else
        [sbsa _updateTimeItems];
#endif
    });
}
