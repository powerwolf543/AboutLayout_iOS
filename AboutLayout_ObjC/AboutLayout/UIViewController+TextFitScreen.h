//
//  UIViewController+TextFitScreen.h
//  AboutLayout
//
//  Created by NixonShih on 2017/1/18.
//  Copyright © 2017年 Nixon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TextFitScreen)
/** 置換當前ViewController內的字體大小，針對 UILabel 以及 UIButton。 */
- (void)changeFontSizeWithScalingRate:(CGFloat)scalingRate;
@end
