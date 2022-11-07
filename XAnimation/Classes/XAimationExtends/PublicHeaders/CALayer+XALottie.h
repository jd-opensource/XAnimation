//
//  CALayer+XALottie.h
//
//
//  Created by xiyuan wang on 2022/3/20.
//

#import <Foundation/Foundation.h>
@class XABindLottieController;
NS_ASSUME_NONNULL_BEGIN

@interface CALayer (XALottie)

//init json, just root layer need to bind.
- (XABindLottieController *)bindLottieWithContentsOfURL:(nonnull NSURL *)url;
- (XABindLottieController *)bindLottieWithAnimationNamed:(NSString *)animationNamed;
- (XABindLottieController *)bindLottieWithFilePath:(NSString *)filePath;

//every node layer under root can bind a name of animated lottie-json-layer.
- (void)bindLottieLayerName:(NSString *)lotLayerName;
- (NSString *)bindLottieLayerName;

- (XABindLottieController *)currentBindController;

@end

NS_ASSUME_NONNULL_END
