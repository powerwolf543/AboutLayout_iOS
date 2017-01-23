//
//  ScalingTextViewController.m
//  AboutLayout
//
//  Created by NixonShih on 2017/1/18.
//  Copyright © 2017年 Nixon. All rights reserved.
//

#import "ScalingTextViewController.h"
#import "UIViewController+TextFitScreen.h"

@interface ScalingTextViewController ()

@end

@implementation ScalingTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 以4寸為基準調整比例
    CGFloat rate = [UIScreen mainScreen].bounds.size.width / 320;
    [self changeFontSizeWithScalingRate:rate];
}

@end
