//
//  XABindLottieDebugWindow.h
//
//
//  Created by xiyuan wang on 2022/3/24.
//

#define XABindLottieDebug 1

#ifdef XABindLottieDebug

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface XABindLottieDebugWindow : UIWindow

@property (nonatomic, strong) UIWindow *appMainWindow;

+ (XABindLottieDebugWindow *)sharedInstance;

+ (double)screenWidth;
+ (double)screenHeight;

@end

NS_ASSUME_NONNULL_END

#endif
