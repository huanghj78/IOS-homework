//
//  FindBackgroundView.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/14.
//

#import "FindBackgroundView.h"

@implementation FindBackgroundView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        0.3, 0.5, 1.0 ,0.2,
        0.5, 0.0, 0.5, 0.2,
        0.5, 0.5, 0.0, 0.2,
        0.0, 0.0, 0.0, 0.1,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, 4);
    //线性渐变起点
    CGPoint start = CGPointMake(0, 0);
    //线性渐变终点
    CGPoint end = CGPointMake(self.frame.size.width, self.frame.size.height);

    CGContextRef graCtx = UIGraphicsGetCurrentContext();
    CGContextDrawLinearGradient(graCtx, gradient, start, end, 0);
    CGGradientRelease(gradient);
    gradient=nil;
    CGColorSpaceRelease(rgb);
}


@end
