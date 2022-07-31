//
//  ResultView.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/31.
//

#import "ResultView.h"
@interface ResultView()
@property(strong, nonatomic) UILabel * label;
@end
@implementation ResultView
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 100)];
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:25];
    [self addSubview:self.label];
    return self;
}
-(void)setAnswer:(NSString*)a{
    self.label.text = [@"正确答案：" stringByAppendingString:a];
}
@end
