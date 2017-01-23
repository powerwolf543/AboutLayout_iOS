//
//  ArrowView.m
//  AboutLayout
//
//  Created by NixonShih on 2017/1/19.
//  Copyright © 2017年 Nixon. All rights reserved.
//

#import "ArrowView.h"

@implementation ArrowView {
    CAShapeLayer *arrowLayer;
}

- (instancetype)init {
    self = [super init];
    [self drawArrow];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    [self drawArrow];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self drawArrow];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 每次 layoutSubviews 的時候都重會一次線。
    arrowLayer.path = [self arrowPath].CGPath;
}

- (void)drawArrow {

    arrowLayer = [CAShapeLayer new];
    arrowLayer.frame = self.bounds;
    arrowLayer.path = [self arrowPath].CGPath;
    arrowLayer.fillColor = [UIColor whiteColor].CGColor;
    
    [self.layer addSublayer:arrowLayer];
}

- (UIBezierPath*)arrowPath {
    CGSize viewSize = self.bounds.size;
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(viewSize.width / 2, viewSize.height)];
    [path addLineToPoint:CGPointMake(viewSize.width, 0)];
    [path closePath];
    return path;
}

@end
