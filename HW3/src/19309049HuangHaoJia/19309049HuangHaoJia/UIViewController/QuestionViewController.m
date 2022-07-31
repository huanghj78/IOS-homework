//
//  QuestionViewController.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/30.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()
@property(strong, nonatomic) QuestionLoader* questionLoader;//获取问题
@property(strong, nonatomic) Question * curQuestion;//当前显示的问题
@property(strong, nonatomic) UIImage* question;//显示问题的图片
@property(strong, nonatomic) UIImageView* imageView;//放置问题图片
@property(strong, nonatomic) UILabel* choice1;//显示选项一
@property(strong, nonatomic) UILabel* choice2;//显示选项二
@property(strong, nonatomic) UILabel* choice3;//显示选项三
@property(strong, nonatomic) UIButton * button;//底部按钮
@property(strong, nonatomic) NSMutableArray * choiceList;//存放当前问题的答案
@property(strong, nonatomic) Judge* theJudge;//判断答案正误
@property(strong, nonatomic) UIGestureRecognizer* click1;//选项一的手势识别
@property(strong, nonatomic) UIGestureRecognizer* click2;//选项二的手势识别
@property(strong, nonatomic) UIGestureRecognizer* click3;//选项三的手势识别
@property(strong, nonatomic) NSString * curChoice;//当前选择的选项
@property(strong, nonatomic) ResultView * resView;//点击确认按钮弹出的UIView
@property(strong, nonatomic) ScoreRecorder * recorder;//记录得分
@property(strong, nonatomic) ScoreViewController * sc;//得分页面
@property(strong, nonatomic) UnitViewController * uc;
@property NSInteger stage;//当前已经答题的数量，答完题目之后跳转至得分页面
@end

@implementation QuestionViewController
-(id)initWithUnitViewController:(UnitViewController *) uc{
    self = [super init];
    self.uc = uc;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //各个属性初始化
    self.choiceList = [[NSMutableArray alloc]init];
    self.questionLoader = [[QuestionLoader alloc]init];
    self.recorder = [[ScoreRecorder alloc]init];
    self.sc = [[ScoreViewController alloc]initWithRecorder:self.recorder andUnitViewController:self.uc];
    [self.questionLoader loadQuestion];
    self.stage = -1;
    self.theJudge = [[Judge alloc]init];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/5, 120, self.view.bounds.size.width*3/5, self.view.bounds.size.width*3/5)];
    //选项文本初始化
    self.choice1 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/10, 400, self.view.bounds.size.width*4/5, 50)];
    self.choice2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/10, 500, self.view.bounds.size.width*4/5, 50)];
    self.choice3 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/10, 600, self.view.bounds.size.width*4/5, 50)];
    //设置选项文字居中
    self.choice1.textAlignment = UIListContentTextAlignmentCenter;
    self.choice2.textAlignment = UIListContentTextAlignmentCenter;
    self.choice3.textAlignment = UIListContentTextAlignmentCenter;
    //设置选项绿色边框
    self.choice1.layer.borderColor = [UIColor greenColor].CGColor;
    self.choice2.layer.borderColor = [UIColor greenColor].CGColor;
    self.choice3.layer.borderColor = [UIColor greenColor].CGColor;
    //设置选项圆角
    self.choice1.layer.cornerRadius = 10.0;
    self.choice2.layer.cornerRadius = 10.0;
    self.choice3.layer.cornerRadius = 10.0;
    //设置选项文字大小
    self.choice1.font = [UIFont systemFontOfSize:28];
    self.choice2.font = [UIFont systemFontOfSize:28];
    self.choice3.font = [UIFont systemFontOfSize:28];
    
    [self.view addSubview:self.choice1];
    [self.view addSubview:self.choice2];
    [self.view addSubview:self.choice3];
    
    //手势识别初始化
    self.click1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(select1)];
    self.click2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(select2)];
    self.click3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(select3)];
    [self.choice1 addGestureRecognizer:self.click1];
    [self.choice2 addGestureRecognizer:self.click2];
    [self.choice3 addGestureRecognizer:self.click3];
    
    //按钮初始化
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/10, self.view.bounds.size.height-100, self.view.bounds.size.width*4/5, 50)];
    
    [self.button setTitle:@"确认" forState:UIControlStateNormal];
    self.button.layer.borderWidth = 1;
    self.button.layer.cornerRadius = 10.0;
    [self.button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:self.button];
    
    //结果视图初始化
    self.resView = [[ResultView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0)];
    [self.view addSubview:self.resView];
}

//主要负责加载题目
- (void)viewWillAppear:(BOOL)animated{
    self.stage++;
    self.curQuestion = [self.questionLoader getQuestion:self.stage];
    self.question = [self.curQuestion getQuestion];
    self.choiceList = [self.curQuestion getChoiceList];
    //呈现问题图片
    [self.imageView setImage:self.question];
    [self.view addSubview:self.imageView];
    //呈现选项
    [self.choice1 setText:[self.choiceList objectAtIndex:0]];
    [self.choice2 setText:[self.choiceList objectAtIndex:1]];
    [self.choice3 setText:[self.choiceList objectAtIndex:2]];
    //刚呈现，未选择时选项为黑色字体且没有边框
    self.choice1.textColor = [UIColor blackColor];
    self.choice2.textColor = [UIColor blackColor];
    self.choice3.textColor = [UIColor blackColor];
    
    self.choice1.layer.borderWidth = 0;
    self.choice2.layer.borderWidth = 0;
    self.choice3.layer.borderWidth = 0;
    
    [self.choice1 setUserInteractionEnabled:TRUE];
    [self.choice2 setUserInteractionEnabled:TRUE];
    [self.choice3 setUserInteractionEnabled:TRUE];
    
    //还未选择选项时底部按钮为灰色且不能响应点击
    [self.button setBackgroundColor:[UIColor grayColor]];
    [self.button setUserInteractionEnabled:FALSE];
}

//弹出自定义的UIView
-(void)openResView:(int)sel{
    //在左上角显示正确答案
    [self.resView setAnswer:[self.theJudge getCorrectAnswer:self.curQuestion]];
    //若答案正确，则背景颜色为绿色
    if(sel == 0){
        [self.resView setBackgroundColor:[UIColor greenColor]];
    }
    //若答案不正确，则背景颜色为红色
    else{
        [self.resView setBackgroundColor:[UIColor redColor]];
    }
    //弹出动画
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.1 animations: ^{
                [self.resView setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0)];
            }];
            [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.4 animations: ^{
                [self.resView setFrame:CGRectMake(0, self.view.bounds.size.height-180, self.view.bounds.size.width, 200)];
                //通过设置透明度使得颜色与按钮颜色区分开
                [self.resView setAlpha:0.3];
            }];
        } completion:nil];
    //将弹出的UIView置于底层，从而不会挡住按钮，使得按钮可以背点击
    [self.view sendSubviewToBack:self.resView];
}


//收回弹出的UIView
-(void)closeResView{
    //一个持续0.5秒的动画
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.1 animations: ^{
                [self.resView setFrame:CGRectMake(0, self.view.bounds.size.height-180, self.view.bounds.size.width, 200)];
            }];
            [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.4 animations: ^{
                [self.resView setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0)];
            }];
        } completion:nil];
}


//底部按钮被点击到响应函数
-(void)btnClick{
    //若当前为“确认”按钮
    if([[self.button currentTitle] isEqual:@"确认"]){
        //选项不能继续响应点击
        [self.choice1 setUserInteractionEnabled:FALSE];
        [self.choice2 setUserInteractionEnabled:FALSE];
        [self.choice3 setUserInteractionEnabled:FALSE];
        //判断用户选择的选项是否正确，然后通过recorder进行分数统计并弹出相应的UIView
        if([self.theJudge judge:[self.curQuestion getID] withChoice:self.curChoice]){
            [self.recorder record:1];
            [self openResView:0];
        }
        else{
            [self.recorder record:0];
            [self.button  setBackgroundColor:[UIColor redColor]];
            [self openResView:1];
        }
        //变为“继续”按钮
        [self.button setTitle:@"继续" forState:UIControlStateNormal];
    }
    //若当前为“继续”按钮
    else{
        [self.button setTitle:@"确认" forState:UIControlStateNormal];
        [self closeResView];
        //若题目已经答完，则跳转至得分页面
        if(self.stage == 3){
            [self.navigationController setViewControllers:@[self.sc]];
        }
        //否则刷新页面，加载新的题目
        else{
            [self viewWillAppear:YES];
        }
    }
}
//选项一的响应函数
-(void)select1{
    self.curChoice = self.choice1.text;
    [self change:1];
}
//选项二的响应函数
-(void)select2{
    self.curChoice = self.choice2.text;
    [self change:2];
}
//选项三的响应函数
-(void)select3{
    self.curChoice = self.choice3.text;
    [self change:3];
}
//负责更新选项的状态
-(void)change:(int)num{
    //有选项被选中，则将底部按钮颜色设置为绿色
    [self.button setBackgroundColor:[[UIColor alloc]initWithRed:10/255.0 green:165/255.0 blue:15/255.0 alpha:1]];
    [self.button setUserInteractionEnabled:TRUE];
    //若当前选中第一个选项，则将其颜色设为绿色并加上边框
    if(num == 1){
        self.choice1.textColor = [UIColor greenColor];
        self.choice2.textColor = [UIColor blackColor];
        self.choice3.textColor = [UIColor blackColor];
        
        self.choice1.layer.borderWidth = 1;
        self.choice2.layer.borderWidth = 0;
        self.choice3.layer.borderWidth = 0;
    }
    if(num == 2){
        self.choice2.textColor = [UIColor greenColor];
        self.choice1.textColor = [UIColor blackColor];
        self.choice3.textColor = [UIColor blackColor];
        
        self.choice1.layer.borderWidth = 0;
        self.choice2.layer.borderWidth = 1;
        self.choice3.layer.borderWidth = 0;
    }
    if(num == 3){
        self.choice3.textColor = [UIColor greenColor];
        self.choice1.textColor = [UIColor blackColor];
        self.choice2.textColor = [UIColor blackColor];
        
        self.choice1.layer.borderWidth = 0;
        self.choice2.layer.borderWidth = 0;
        self.choice3.layer.borderWidth = 1;
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
