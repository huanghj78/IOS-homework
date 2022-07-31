//
//  MineBackgroundView.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/14.
//

#import "MineBackgroundView.h"

@implementation MineBackgroundView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        0.0, 0.0, 0.0 ,0.2,
        1.0, 0.0, 0.0, 0.4,
        0.6, 0.6, 0.2, 0.2,
        0.0, 0.0, 0.0, 0.6,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, 2);

    CGPoint start = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGPoint end = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat startRadius = 0.0f;
    CGFloat endRadius = 400;
    CGContextRef graCtx = UIGraphicsGetCurrentContext();
    CGContextDrawRadialGradient(graCtx, gradient, start, startRadius, end, endRadius, 0);
    CGGradientRelease(gradient);
    gradient=NULL;
    CGColorSpaceRelease(rgb);
}


@end
