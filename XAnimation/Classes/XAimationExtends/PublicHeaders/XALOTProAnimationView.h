//
//  XALOTProAnimationView.h
//  
//
//  Created by xiyuan wang on 2022/3/29.
//

#import <XAnimation/LOTAnimationView.h>
#import "XALOTProAnimationViewDataSource.h"
#import "XALOTProAnimationViewDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface XALOTProAnimationView : LOTAnimationView

@property (nonatomic, weak) id<XALOTProAnimationViewDataSource> dataSource;
@property (nonatomic, weak) id<XALOTProAnimationViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
