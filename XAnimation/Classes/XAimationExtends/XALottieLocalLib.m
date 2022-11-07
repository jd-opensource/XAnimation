//
//  XALottieLocalLib.m
//
//
//  Created by xiyuan wang on 2022/3/24.
//

#import "XALottieLocalLib.h"

@implementation XALottieLocalLib

+ (NSString *)filePathForLocalLibWithName:(NSString *)lottieName{
    NSURL *mockBundleURL = [[NSBundle mainBundle] URLForResource:@"XALottieResource" withExtension:@"bundle"]; //TODO
    if (mockBundleURL) {
        NSBundle *bundle = [NSBundle bundleWithURL:mockBundleURL]; //为nil会崩溃
        if (bundle) {
            NSString *filePath = [bundle pathForResource:lottieName ofType:@"json"  inDirectory:@"lotlib"];
            return filePath;
        }
    }
    return nil;
}

@end
