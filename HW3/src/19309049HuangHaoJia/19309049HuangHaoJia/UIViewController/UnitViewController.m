//
//  UnitViewController.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/30.
//

#import "UnitViewController.h"

@interface UnitViewController ()
@property(strong, nonatomic) ViewController* su;
@property(strong, nonatomic) QuestionViewController* qc;
@property(strong, nonatomic) UIView* circleView;//圆形视图
@property(strong, nonatomic) UILabel* label;//登录提示文字

@end

@implementation UnitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.qc = [[QuestionViewController alloc]initWithUnitViewController:self];
    if(self.circleView == nil) {
        self.circleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,200)];
        self.circleView.center = self.view.center;
        self.circleView.alpha = 0.5;
        //设置为圆形
        self.circleView.layer.cornerRadius = 100;
        
        //设置渐变层
        CAGradientLayer *gradient = [CAGradientLayer layer];
        //设置渐变开始和结束位置(设置渐变的方向)
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(1, 1);
        gradient.frame = CGRectMake(0,0,200,200);
        gradient.cornerRadius = 100;
        //渐变的颜色为紫色、红色、白色
        gradient.colors = [NSArray arrayWithObjects:(id)[UIColor purpleColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor whiteColor].CGColor,nil];
        [self.circleView.layer insertSublayer:gradient atIndex:0];
        
        //添加点击识别手势
        UIGestureRecognizer* click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goSelect)];
        [self.circleView addGestureRecognizer:click];
        [self.view addSubview:self.circleView];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 58)];
        self.label.center = self.view.center;
        self.label.text = @"识别";
        self.label.font = [UIFont systemFontOfSize:28];
        [self.view addSubview:self.label];
    }
}

//点击之后跳转至选择题页面
- (void)goSelect{
    [self.navigationController setViewControllers:@[self.qc]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
