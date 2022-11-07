//
//  TestBind5.m
//  XAnimation_Example
//
//  Created by xiyuan wang on 2022/4/13.
//  Copyright © 2022 wangxiyuan. All rights reserved.
//

#define pointRotatedAroundAnchorPoint(point,anchorPoint,angle) CGPointMake((point.x-anchorPoint.x)*cos(angle) - (point.y-anchorPoint.y)*sin(angle) + anchorPoint.x, (point.x-anchorPoint.x)*sin(angle) + (point.y-anchorPoint.y)*cos(angle)+anchorPoint.y)

#import "TestBind5.h"

@interface TestBind5 ()

@property (nonatomic, strong) UIImageView *imgV0, *imgV1;

@end

@implementation TestBind5

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    UIImageView *imgV0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paizi"]];
    imgV0.layer.borderColor = [UIColor blueColor].CGColor;
    imgV0.layer.borderWidth = 1;
    imgV0.frame = CGRectMake(100, 100, 50, 50);
    [self.view addSubview:imgV0];
    _imgV0 = imgV0;
    
    UIImageView *imgV1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paizi"]];
    imgV1.layer.borderColor = [UIColor blueColor].CGColor;
    imgV1.layer.borderWidth = 1;
    imgV1.frame = CGRectMake(100, 300, 50, 50);
    [self.view addSubview:imgV1];
    _imgV1 = imgV1;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self mockAnim1];
    });
    
    for (int idx = 0; idx < 20; idx ++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50 * idx, CGRectGetWidth(self.view.bounds), 1)];
        line.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        [self.view addSubview:line];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(50 * idx, 0, 1, CGRectGetHeight(self.view.bounds))];
        line1.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        [self.view addSubview:line1];
    }
}

/*
- (void)mockAnim1{
//    _imgV0.layer.anchorPoint = CGPointMake(0, 0);
    
    // reset imgv1 anchor
    CGPoint img1OldAnchorPt = _imgV1.layer.anchorPoint;
    CGPoint img1NewAnchorPt = CGPointMake(0, 0);
    CGFloat xMoveFix = (img1NewAnchorPt.x - img1OldAnchorPt.x) * CGRectGetWidth(_imgV1.bounds);
    CGFloat yMoveFix = (img1NewAnchorPt.y - img1OldAnchorPt.y) * CGRectGetHeight(_imgV1.bounds);
    _imgV1.layer.anchorPoint = img1NewAnchorPt;
    _imgV1.layer.position = CGPointMake(_imgV1.layer.position.x + xMoveFix, _imgV1.layer.position.y + yMoveFix);
    
    
    
    CGFloat scale = 2;
    CGPoint translation = CGPointMake(50, 50);
    CGFloat rotate = M_PI;
    
    CGFloat leftOffsetByScale0 = _imgV0.frame.size.width * _imgV0.layer.anchorPoint.x * (scale - 1) * -1;
    CGFloat topOffsetByScale0 = _imgV0.frame.size.height * _imgV0.layer.anchorPoint.y * (scale - 1) * -1;
    
    CGFloat leftOffsetByScale1 = _imgV1.frame.size.width * _imgV1.layer.anchorPoint.x * (scale - 1) * -1;
    CGFloat topOffsetByScale1 = _imgV1.frame.size.height * _imgV1.layer.anchorPoint.y * (scale - 1) * -1;

    
    // lottie layer
    CATransform3D translateXform1 = CATransform3DTranslate(CATransform3DIdentity, translation.x, translation.y, 0);
    CATransform3D scaleXform1 = CATransform3DScale(translateXform1, scale, scale, 1);
    CATransform3D rotateXform1 = CATransform3DRotate(CATransform3DIdentity, rotate, 0, 0, 1);
    
    
    CGPoint refAnchor = _imgV1.layer.anchorPoint;
    CGPoint leftTopPoint = CGPointMake(_imgV0.layer.position.x - _imgV0.frame.size.width * _imgV0.layer.anchorPoint.x, _imgV0.layer.position.y - _imgV0.frame.size.height * _imgV0.layer.anchorPoint.y);
    CGPoint refAnchorPos = CGPointMake(leftTopPoint.x + _imgV0.frame.size.width * refAnchor.x, leftTopPoint.y + _imgV0.frame.size.height * refAnchor.y);
//    CGPoint refAnchorPosOnSelfCoordinate = CGPointMake(refAnchorPos.x - _imgV0.layer.position.x, refAnchorPos.y - _imgV0.layer.position.y);
    CGPoint refAnchorPosAfterRotate = pointRotatedAroundAnchorPoint(refAnchorPos, _imgV0.layer.position, rotate);
    CGPoint refAnchorMoveChange = CGPointMake(refAnchorPosAfterRotate.x - refAnchorPos.x, refAnchorPosAfterRotate.y - refAnchorPos.y);
    
    CGPoint translation_buchangRotate = CGPointMake(0 - refAnchorMoveChange.x, 0 - refAnchorMoveChange.y);
    
    // app layer
    CATransform3D translateXform0 = CATransform3DTranslate(CATransform3DIdentity, translation.x - (leftOffsetByScale0 - leftOffsetByScale1) , translation.y - (topOffsetByScale0 - topOffsetByScale1), 0);
    CATransform3D scaleXform0 = CATransform3DScale(translateXform0, scale, scale, 1);
    

    CATransform3D translateXformbuchang = CATransform3DTranslate(CATransform3DIdentity, translation_buchangRotate.x, translation_buchangRotate.y, 0);
    CATransform3D rotateXform0 = CATransform3DRotate(translateXformbuchang, rotate, 0, 0, 1);


    [UIView animateWithDuration:3 animations:^{
        if (@available(iOS 13.0, *)) {
            self.imgV0.transform3D = rotateXform0;
            self.imgV1.transform3D = rotateXform1;
        }
    } completion:^(BOOL finished) {
    }];
}
*/

- (void)mockAnim1{
//    _imgV0.layer.anchorPoint = CGPointMake(0, 0);
    
    // reset imgv1 anchor
    CGPoint img1OldAnchorPt = _imgV1.layer.anchorPoint;
    CGPoint img1NewAnchorPt = CGPointMake(0.3, 0.8);
    CGFloat xMoveFix = (img1NewAnchorPt.x - img1OldAnchorPt.x) * CGRectGetWidth(_imgV1.bounds);
    CGFloat yMoveFix = (img1NewAnchorPt.y - img1OldAnchorPt.y) * CGRectGetHeight(_imgV1.bounds);
    _imgV1.layer.anchorPoint = img1NewAnchorPt;
    _imgV1.layer.position = CGPointMake(_imgV1.layer.position.x + xMoveFix, _imgV1.layer.position.y + yMoveFix);
    
    
    
    CGFloat scale = 3;
    CGPoint translation = CGPointMake(0, 0);
    CGFloat rotateValue = M_PI / 2;
    
//    CGFloat leftOffsetByScale0 = _imgV0.frame.size.width * _imgV0.layer.anchorPoint.x * (scale - 1) * -1;
//    CGFloat topOffsetByScale0 = _imgV0.frame.size.height * _imgV0.layer.anchorPoint.y * (scale - 1) * -1;
//
//    CGFloat leftOffsetByScale1 = _imgV1.frame.size.width * _imgV1.layer.anchorPoint.x * (scale - 1) * -1;
//    CGFloat topOffsetByScale1 = _imgV1.frame.size.height * _imgV1.layer.anchorPoint.y * (scale - 1) * -1;

    
    // lottie layer
    CATransform3D translateXform1 = CATransform3DTranslate(CATransform3DIdentity, translation.x, translation.y, 0);
    CATransform3D scaleXform1 = CATransform3DScale(translateXform1, scale, scale, 1);
    CATransform3D rotateXform1 = CATransform3DRotate(scaleXform1, rotateValue, 0, 0, 1);
    
    
    // caculate buchang
    CGPoint refAnchor = _imgV1.layer.anchorPoint;
    CGPoint leftTopPoint = CGPointMake(_imgV0.layer.position.x - _imgV0.bounds.size.width * _imgV0.layer.anchorPoint.x, _imgV0.layer.position.y - _imgV0.bounds.size.height * _imgV0.layer.anchorPoint.y);
    CGPoint refAnchorPos = CGPointMake(leftTopPoint.x + _imgV0.bounds.size.width * refAnchor.x, leftTopPoint.y + _imgV0.bounds.size.height * refAnchor.y);
    CGPoint refAnchorPosOnSelfCoordinate = CGPointMake(refAnchorPos.x - _imgV0.layer.position.x, refAnchorPos.y - _imgV0.layer.position.y);
    CGPoint refAnchorPosOnSelfCoordinate_S = CGPointMake(refAnchorPosOnSelfCoordinate.x * scale, refAnchorPosOnSelfCoordinate.y * scale);
    CGPoint refAnchorPosOnSelfCoordinate_S_R = pointRotatedAroundAnchorPoint(refAnchorPosOnSelfCoordinate_S, CGPointZero, rotateValue);
    CGPoint refAnchorMoveChange = CGPointMake(refAnchorPosOnSelfCoordinate_S_R.x - refAnchorPosOnSelfCoordinate.x, refAnchorPosOnSelfCoordinate_S_R.y - refAnchorPosOnSelfCoordinate.y);
    CGPoint translation_buchang = CGPointMake(translation.x - refAnchorMoveChange.x, translation.y - refAnchorMoveChange.y);
    
    // app layer
    CATransform3D translateXform0 = CATransform3DTranslate(CATransform3DIdentity, translation_buchang.x, translation_buchang.y, 0);
    CATransform3D scaleXform0 = CATransform3DScale(translateXform0, scale, scale, 1);
    CATransform3D rotateXform0 = CATransform3DRotate(scaleXform0, rotateValue, 0, 0, 1);


    [UIView animateWithDuration:3 animations:^{
        if (@available(iOS 13.0, *)) {
            self.imgV0.transform3D = rotateXform0;
            self.imgV1.transform3D = rotateXform1;
        }
    } completion:^(BOOL finished) {
    }];
}

@end
