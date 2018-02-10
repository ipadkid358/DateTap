#import "DTShared.h"

@interface _UIStatusBarStringView : UIView
@end

@interface UIStatusBarTimeItemView : UIView
@end

#ifdef BuildForiPhoneX
static BOOL isX = YES;
#else
static BOOL isX = NO;
#endif

%group ForX

%hook _UIStatusBarTimeItem

- (_UIStatusBarStringView *)shortTimeView {
    _UIStatusBarStringView *view = %orig;
    view.userInteractionEnabled = YES;
    
    if (view.gestureRecognizers) {
        return view;
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDateTap:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [view addGestureRecognizer:tapRecognizer];
    
    return view;
}

%new
- (void)handleDateTap:(UITapGestureRecognizer *)sender {
    notify_post(kPostNotifToggleKey);
}

%end

%end


%group NonX

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

%end

%ctor {
    if (isX) {
        %init(ForX);
    } else {
        %init(NonX);
    }
}
