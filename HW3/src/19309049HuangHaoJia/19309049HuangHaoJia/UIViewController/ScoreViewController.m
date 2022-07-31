//
//  ScoreViewController.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/31.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()
@property(strong, nonatomic) ScoreRecorder* recorder;//分数记录器
@property(strong, nonatomic) UILabel * label;//“正确数“文本
@property(strong, nonatomic) UILabel * scoreLabel;//显示正确的题目数
@property(strong, nonatomic) NSMutableArray * records;//存放各个题目的答题记录（正确与否）
@property(strong, nonatomic) UIImage * star0;//空心星星图片
@property(strong, nonatomic) UIImage * star1;//实心星星图片
@property(strong, nonatomic) NSMutableArray * imgViews;//分别放置四个星星图片
@property(strong, nonatomic) UIButton * button;// 返回按钮
@property(strong, nonatomic) UnitViewController * uc;//存放初始界面，方便返回
@property NSInteger score;//得分
@end
@implementation ScoreViewController

//使得与QuestionViewController共用一个ScoreRecorder，且能够返回到一开始的初始界面
-(id)initWithRecorder:(ScoreRecorder*)r andUnitViewController:(UnitViewController*)uc{
    self = [super init];
    self.recorder = r;
    self.uc = uc;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.score = 0;
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/5, 120, self.view.bounds.size.width*3/5, self.view.bounds.size.width*3/5)];
    self.label.text = @"正确数";
    self.label.font = [UIFont systemFontOfSize:28];
    self.label.textAlignment = UIListContentTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    self.scoreLabel =  [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/5, 300, self.view.bounds.size.width*3/5, self.view.bounds.size.width*3/5)];
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld",self.score];
    self.scoreLabel.font = [UIFont systemFontOfSize:28];
    self.scoreLabel.textAlignment = UIListContentTextAlignmentCenter;
    [self.view addSubview:self.scoreLabel];
    
    self.star0 = [UIImage imageNamed:@"star0.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    self.star1 = [UIImage imageNamed:@"star1.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    
    self.imgViews = [[NSMutableArray alloc]init];
    //初始化四个星星的位置
    for(int i = 0;i < 4;++i){
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/6*i+(i+1)*self.view.bounds.size.width/15, 600, self.view.bounds.size.width/6, 80)];
        [self.imgViews addObject:iv];
        [iv setImage:self.star0];
        [self.view addSubview:iv];
    }
    self.records = [self.recorder getRecords];
    
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/10, self.view.bounds.size.height-100, self.view.bounds.size.width*4/5, 50)];
    [self.button setTitle:@"返回" forState:UIControlStateNormal];
    self.button.layer.borderWidth = 1;
    self.button.layer.cornerRadius = 10.0;
    [self.button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.button setBackgroundColor:[[UIColor alloc]initWithRed:10/255.0 green:165/255.0 blue:15/255.0 alpha:1]];
    [self.view  addSubview:self.button];
    
    self.uc = [[UnitViewController alloc]init];
}
-(void)btnClick{
    [self.navigationController setViewControllers:@[self.uc]];
}
-(void)viewWillAppear:(BOOL)animated{
    //从左到右依次放大缩小动画
    for(int i = 0;i < 4;++i){
        [UIView animateKeyframesWithDuration:0.5 delay:i*0.5 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
                [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations: ^{
                    [[self.imgViews objectAtIndex:i] setFrame:CGRectMake(self.view.bounds.size.width/6*i+(i+1)*self.view.bounds.size.width/15-25, 580, self.view.bounds.size.width/6+50, 120)];
                }];
            [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.2 animations: ^{
                    [[self.imgViews objectAtIndex:i] setFrame:CGRectMake(self.view.bounds.size.width/6*i+(i+1)*self.view.bounds.size.width/15, 600, self.view.bounds.size.width/6, 80)];
                }];
        } completion:^(BOOL finished){
            //若对应的题目回答正确则变为实心星星
            if([[self.records objectAtIndex:i] isEqual:@"1"]){
                [[self.imgViews objectAtIndex:i] setImage:self.star1];
                self.score++;
                self.scoreLabel.text = [NSString stringWithFormat:@"%ld",self.score];
            }
            
        }];
    }
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
