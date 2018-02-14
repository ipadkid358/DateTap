#import "DTShared.h"

@interface UIStatusBarTimeItemView : UIView
@end

%hook UIStatusBarTimeItemView

- (void)setFrame:(CGRect)arg1 {
    %orig;
    self.userInteractionEnabled = YES;
    
    if (self.gestureRecognizers) {
        return;
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDateTap:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tapRecognizer];
}

%new
- (void)handleDateTap:(UITapGestureRecognizer *)sender {
    notify_post(kPostNotifToggleKey);
}

%end
