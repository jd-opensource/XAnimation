/*
 * Copyright (C) 2018 Airbnb, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * Modifications copyright (C) 2022 JD.com, Inc.
 */

//
//  LOTTransformInterpolator.h
//  Lottie
//
//  Created by brandon_withrow on 7/18/17.
//  Copyright © 2017 Airbnb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LOTNumberInterpolator.h"
#import "LOTPointInterpolator.h"
#import "LOTSizeInterpolator.h"
#import "LOTKeyframe.h"
#import "LOTLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface LOTTransformInterpolator : NSObject

+ (instancetype)transformForLayer:(LOTLayer *)layer;

- (instancetype)initWithPosition:(NSArray <LOTKeyframe *> *)position
                        rotation:(NSArray <LOTKeyframe *> *)rotation
                          anchor:(NSArray <LOTKeyframe *> *)anchor
                           scale:(NSArray <LOTKeyframe *> *)scale;

- (instancetype)initWithPositionX:(NSArray <LOTKeyframe *> *)positionX
                        positionY:(NSArray <LOTKeyframe *> *)positionY
                         rotation:(NSArray <LOTKeyframe *> *)rotation
                           anchor:(NSArray <LOTKeyframe *> *)anchor
                            scale:(NSArray <LOTKeyframe *> *)scale;

@property (nonatomic, strong) LOTTransformInterpolator * inputNode;

@property (nonatomic, readonly) LOTPointInterpolator *positionInterpolator;
@property (nonatomic, readonly) LOTPointInterpolator *anchorInterpolator;
@property (nonatomic, readonly) LOTSizeInterpolator *scaleInterpolator;
@property (nonatomic, readonly) LOTNumberInterpolator *rotationInterpolator;
@property (nonatomic, readonly) LOTNumberInterpolator *positionXInterpolator;
@property (nonatomic, readonly) LOTNumberInterpolator *positionYInterpolator;
@property (nonatomic, strong, nullable) NSString *parentKeyName;

- (CATransform3D)transformForFrame:(NSNumber *)frame;
- (BOOL)hasUpdateForFrame:(NSNumber *)frame;

//@wxy modify
- (NSDictionary *)transformDicForFrame:(NSNumber *)frame;

@end

NS_ASSUME_NONNULL_END
