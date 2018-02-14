#import <objc/runtime.h>
#import "DTShared.h"

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
        
        NSDateFormatter *timeFormat = [sbsa valueForKey:@"_timeItemDateFormatter"];
        
        timeFormat.dateStyle = showDate;
        timeFormat.timeStyle = !showDate;
        
        [sbsa _updateTimeItems];
    });
}
