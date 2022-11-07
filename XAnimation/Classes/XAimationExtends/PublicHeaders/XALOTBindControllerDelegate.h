//
//  XALOTBindControllerDelegate.h
//  
//
//  Created by xiyuan wang on 2022/4/11.
//

#import <Foundation/Foundation.h>

@class XABindLottieController;

NS_ASSUME_NONNULL_BEGIN

@protocol XALOTBindControllerDelegate <NSObject>

- (void)bindController:(XABindLottieController *)bindController didUpdateProgress:(CGFloat)progress;
- (void)bindController:(XABindLottieController *)bindController layerEnterForName:(NSString *)layerName;
- (void)bindController:(XABindLottieController *)bindController layerOutForName:(NSString *)layerName;

@end

NS_ASSUME_NONNULL_END
