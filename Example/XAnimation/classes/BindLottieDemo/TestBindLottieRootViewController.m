//
//  TestBindLottieRootViewController.m
//  XAnimation_Example
//
//  Created by xiyuan wang on 2022/3/24.
//  Copyright © 2022 wangxiyuan. All rights reserved.
//

#import "TestBindLottieRootViewController.h"
#import <XAnimation/LOTAnimationView.h>
#import <XAnimation/UIView+XALottie.h>
#import <XAnimation/XABindLottieController.h>

@interface TestBindLottieRootViewController ()

@property (strong, nonatomic) UIView *testBindView;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *classNames;

@end

@implementation TestBindLottieRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"绑定 Lottie 测试";
    self.titles = @[
         @"绑定（旋转 平移 缩放）",
         @"绑定（呼吸效果）",
         @"2个图层联动",
         @"播放控制",
         @"动态更换内容",
         @"锚点适配",
    ];
    self.classNames = @[
        @"TestBind0",
        @"TestBind1",
        @"TestBind2",
        @"TestBind3",
        @"TestBind4",
        @"TestBind5",
    ];
    [self runTest];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)runTest{
    self.view.backgroundColor = [UIColor purpleColor];

    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.dataSource = self;
    table.delegate = self;
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:table];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.text = [NSString stringWithFormat:@"演示%ld:    %@", indexPath.row + 1, self.titles[indexPath.row]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = self.classNames[indexPath.row];
    Class cls = NSClassFromString(className);
    if (cls) {
        UIViewController *vc = [cls new];
        vc.title = self.titles[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
