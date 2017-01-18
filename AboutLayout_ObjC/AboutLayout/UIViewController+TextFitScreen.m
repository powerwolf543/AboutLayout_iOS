//
//  UIViewController+TextFitScreen.m
//  AboutLayout
//
//  Created by NixonShih on 2017/1/18.
//  Copyright © 2017年 Nixon. All rights reserved.
//

#import "UIViewController+TextFitScreen.h"

@implementation UIViewController (TextFitScreen)

- (void)changeFontSizeWithScalingRate:(CGFloat)scalingRate {
    [self findTextWithView:self.view
            andScalingRate:scalingRate];
}

- (void)findTextWithView:(UIView*)theView
          andScalingRate:(CGFloat)scalingRate {
    
    for (UIView *theSubView in theView.subviews) {
        
        [self findTextWithView:theSubView
                andScalingRate:scalingRate];
        
        if ([theSubView isKindOfClass:[UILabel class]]) {
            UILabel *theLabel = (UILabel*)theSubView;
            [self scalingFontSizeWithLabel:theLabel
                                   andRate:scalingRate];
        }
        
        if ([theSubView isKindOfClass:[UIButton class]]) {
            UIButton *theButton = (UIButton*)theSubView;
            [self scalingFontSizeWithButton:theButton
                                    andRate:scalingRate];
        }
    }
}

- (void)scalingFontSizeWithLabel:(UILabel*)theLabel
                         andRate:(CGFloat)rate {
    theLabel.font = [UIFont fontWithName:theLabel.font.fontName
                                    size:theLabel.font.pointSize * rate];
}

- (void)scalingFontSizeWithButton:(UIButton*)theButton
                          andRate:(CGFloat)rate {
    theButton.titleLabel.font = [UIFont fontWithName:theButton.titleLabel.font.fontName
                                                size:theButton.titleLabel.font.pointSize * rate];
}

@end
