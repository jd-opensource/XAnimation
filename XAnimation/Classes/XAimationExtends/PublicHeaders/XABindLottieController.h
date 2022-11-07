//
//  XABindLottieController.h
//
//
//  Created by xiyuan wang on 2022/3/30.
//

#import <Foundation/Foundation.h>
#import "XALOTBindControllerDataSource.h"
#import "XALOTBindControllerDelegate.h"

@class XABindLOTAnimationView;

typedef void (^XABindLottieCompletionBlock)(BOOL animationFinished);
typedef void (^XABindLottieLoadCompletionBlock)(BOOL loadFinished);

NS_ASSUME_NONNULL_BEGIN

@interface XABindLottieController : NSObject


@property (nonatomic, weak, readonly) id host;
@property (nonatomic, weak) id<XALOTBindControllerDataSource> dataSource;
@property (nonatomic, weak) id<XALOTBindControllerDelegate> delegate;
@property (nonatomic, assign) BOOL loopAnimation;

+ (XABindLottieController *)bindLottieWithContentsOfURL:(nonnull NSURL *)url toHost:(id)host;
+ (XABindLottieController *)bindLottieWithAnimationNamed:(NSString *)animationNamed toHost:(id)host;
+ (XABindLottieController *)bindLottieWithFilePath:(NSString *)filePath toHost:(id)host;

- (void)play;
- (void)playFromProgress:(CGFloat)fromStartProgress
              toProgress:(CGFloat)toEndProgress
          withCompletion:(nullable XABindLottieCompletionBlock)completion;
- (void)pause;
- (void)stop;

- (CGFloat)currentProgress;

@end

NS_ASSUME_NONNULL_END
