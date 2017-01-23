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
            [self scalingTextWithLabel:theLabel
                               andRate:scalingRate];
        }
        
        if ([theSubView isKindOfClass:[UIButton class]]) {
            UIButton *theButton = (UIButton*)theSubView;
            [self scalingTextWithButton:theButton
                                andRate:scalingRate];
        }
    }
}

- (void)scalingTextWithLabel:(UILabel*)theLabel
                     andRate:(CGFloat)rate {
    theLabel.font = [UIFont fontWithName:theLabel.font.fontName
                                    size:theLabel.font.pointSize * rate];
}

- (void)scalingTextWithButton:(UIButton*)theButton
                      andRate:(CGFloat)rate {
    [self scalingTextWithLabel:theButton.titleLabel andRate:rate];
}

@end
