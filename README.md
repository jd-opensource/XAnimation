# XAnimation

[![CI Status](https://img.shields.io/travis/wangxiyuan/XAnimation.svg?style=flat)](https://travis-ci.org/wangxiyuan/XAnimation)
[![Version](https://img.shields.io/cocoapods/v/XAnimation.svg?style=flat)](https://cocoapods.org/pods/XAnimation)
[![License](https://img.shields.io/cocoapods/l/XAnimation.svg?style=flat)](https://cocoapods.org/pods/XAnimation)
[![Platform](https://img.shields.io/cocoapods/p/XAnimation.svg?style=flat)](https://cocoapods.org/pods/XAnimation)


## Introduce 简介 😊

<font face="微软雅黑" size="3">使用 **XAnimation**， 你可以快速将设计师设计的动画效果，应用到你的 App 中现有的任何视图（或图层）上，由于 XAnimation 基于 **Lottie** 进行二次开源，因此它同样具备以下特征：</font>

* **<font face="微软雅黑" size="3" color="orange">高还原度 🎆</font>**
* **<font face="微软雅黑" size="3"  color="orange">少代码 ♻️</font>**
* **<font face="微软雅黑" size="3"  color="orange">高稳定性 💪</font>**

<center class="half">
    <img src="https://m.360buyimg.com/img/jfs/t1/173991/10/29856/153907/6322edf7E24daff56/25206a5a6cac1771.png" style="margin-right: 10px" width="600"/>
</center>


## Example 效果预览

> 你可以在 Example 工程中体验它。

<div>
    <img src="https://storage.360buyimg.com/xview/xanimation/p1.gif" style="border:#000000 3px solid;  margin-right: 10px;margin-bottom: 10px" width="260"/>
    <img src="https://storage.360buyimg.com/xview/xanimation/p2.gif" style="border:#000000 3px solid;  margin-right: 10px;margin-bottom: 10px" width="260"/>
    <img src="https://storage.360buyimg.com/xview/xanimation/p3.gif" style="border:#000000 3px solid;  margin-right: 10px;margin-bottom: 10px" width="260"/>
    <img src="https://storage.360buyimg.com/xview/xanimation/p4.gif" style="border:#000000 3px solid;  margin-right: 10px;margin-bottom: 10px" width="260"/>
    <img src="https://storage.360buyimg.com/xview/xanimation/p5.gif" style="border:#000000 3px solid;  margin-right: 10px;margin-bottom: 10px" width="260"/>
    <img src="https://storage.360buyimg.com/xview/xanimation/p6.gif" style="border:#000000 3px solid;  margin-right: 10px;margin-bottom: 10px" width="260"/>
</div>


## Requirements
<font face="微软雅黑" size="2">iOS 9.0+</font>
<br />

## Installation 安装

<font face="微软雅黑" size="3">XAnimation 可以通过 CocoaPods 来安装 (https://cocoapods.org) 只需要将下面代码加入到 Podfile 中。</font>

```ruby
pod install 'XAnimation'
```

## API 使用

> 以下调示例为 UIView 绑定动画， CALayer 可以直接去源码看相关接口定义.

<font face="微软雅黑" size="3">

1. 依赖头文件.
```objc
#import <XAnimation/UIView+XALottie.h>
#import <XAnimation/XABindLottieController.h>
```

2.  Lottie 绑定到一个根 UIView（或 CALayer）上.
```objc
/**
 * animationName 即为本地Json文件名
 * aView 你的任意一个视图
 */
[aView bindLottieWithAnimationNamed:@"牌子动画（旋转+位移+缩放）"];
```

3. 你的视图绑定 Lottie json 中某个图层.
```objc
[aView bindLottieLayerName:@"牌子"];
```

4. 播放动画.
```objc
[[aView currentBindController] play];
```
</font>

## Future 展望
<font face="微软雅黑" size="3" color="#696969">
请试想，动画绑定的能力该如何运用呢？
<br/>
每个人可能都有不同想法 🤔， 但这里有一个推荐，我现在对上面的流程做一点点改进，将 App 中的视图和 Lottie 中的图层的绑定关系，改为后台配置，这样流程看起来会像下图：
</font>

<center class="half">
    <img src="https://storage.360buyimg.com/xview/xanimation/XAConfig.png" style="margin-right: 10px" width="700"/>
</center>

<font face="微软雅黑" size="3">这样做的好处是：</font>
- <font face="微软雅黑" size="3" color="orange">0 代码开发，任意时刻配置，可立即上线</font>
- <font face="微软雅黑" size="3" color="orange">减少测试环节，由平台提供稳定性，提高效能</font>

<font face="微软雅黑" size="3">好了，现在你能想到哪些配置应用场景呢？比如：春节的时候🧨🧨🧨，让你的大 Icon 开心的跳起来？😄</font>


## Author 作者

<font face="微软雅黑" size="3">wangxiyuan (wangxiyuan613@163.com)</font>
<br/>
如果你有更多更好的想法，欢迎发件交流 🤝🤝🤝。

## License 版权
<font face="微软雅黑" size="3">
XAnimation is available under the Apache License 2.0. See the LICENSE file for more info.
</font>

