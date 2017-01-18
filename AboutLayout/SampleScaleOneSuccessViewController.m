//
//  SampleScaleOneSuccessViewController.m
//  AboutLayout
//
//  Created by NixonShih on 2017/1/17.
//  Copyright © 2017年 Nixon. All rights reserved.
//

#import "SampleScaleOneSuccessViewController.h"
#import "UIViewController+LabelTextFitScreen.h"

@interface SampleScaleOneSuccessViewController ()

@end

@implementation SampleScaleOneSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 以4吋機型為例
    CGFloat rate = [UIScreen mainScreen].bounds.size.width / 320;
    [self changeLabelFontSizeWithScaleRate:rate];
}

@end
