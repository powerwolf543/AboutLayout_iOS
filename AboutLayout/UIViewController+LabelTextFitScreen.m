//
//  UIViewController+LabelTextFitScreen.m
//  AboutLayout
//
//  Created by NixonShih on 2017/1/17.
//  Copyright © 2017年 Nixon. All rights reserved.
//

#import "UIViewController+LabelTextFitScreen.h"

@implementation UIViewController (LabelTextFitScreen)

- (void)changeLabelFontSizeWithScaleRate:(CGFloat)scaleRate {
    [self findLabelWithView:self.view andScaleRate:scaleRate];
}

- (void)findLabelWithView:(UIView*)theView
             andScaleRate:(CGFloat)scaleRate {
    
    for (UIView *theSubView in theView.subviews) {
        
        [self findLabelWithView:theSubView
                   andScaleRate:scaleRate];
        
        if ([theSubView isKindOfClass:[UILabel class]]) {
            UILabel *theLabel = (UILabel*)theSubView;
            theLabel.font = [UIFont fontWithName:theLabel.font.fontName
                                            size:theLabel.font.pointSize * scaleRate];
        }
    }
}

@end
