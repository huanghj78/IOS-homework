//
//  FindViewController.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/8.
//

#import <Foundation/Foundation.h>
#import "FindViewController.h"
#import "DetailViewController.h"
//添加代理
@interface FindViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property(strong, nonatomic)UITableView * tableView;//用来组织记录清单
@property(strong, nonatomic)RecordsController * rc;//Record控制器，方便对记录的存储进行操作
@property(strong, nonatomic)UISearchBar * searchBar;//搜索框
@property(strong, nonatomic)UIViewController * su;//父视图控制器
@property(strong, nonatomic)FindBackgroundView * bgView;//背景
@property(strong, nonatomic)NSMutableArray * dataArray;//存储当前的穿搭记录
@property(strong, nonatomic)NSMutableArray * searchResult;//存储符合搜索条件的穿搭记录
@property(nonatomic)NSInteger num;// 当前穿搭记录总数
@property(nonatomic)NSInteger flag;//搜索标志位，0-无搜索，1-正在搜索
@end

@implementation FindViewController
//初始化并记录下父视图控制器，方便修改导航栏标题
-(id)initWithSuper:(UIViewController*)su{
    self = [super init];
    self.su = su;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag = 0;
    self.su.title = @"穿搭记录";
    self.title = @"Find";
    //[self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    //初始化Record控制器，方便对记录的存储进行操作
    self.rc = [[RecordsController alloc]init];
    self.searchResult = [[NSMutableArray alloc]init];
    
    self.bgView = [[FindBackgroundView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.bgView];
    
//    UIImage * findImg = [UIImage imageNamed:@"find.jpg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
//    UIImage * findImg1 = [UIImage imageNamed:@"find1.jpg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
//    UIImage * recordImg = [UIImage imageNamed:@"record.jpg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
//    UIImage * recordImg1 = [UIImage imageNamed:@"record1.jpg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
//    UIImage * mineImg = [UIImage imageNamed:@"mine.jpg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
//    UIImage * mineImg1 = [UIImage imageNamed:@"mine1.jpg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
//    Records* r1 = [[Records alloc]init:@"2021-01-02" at:@"school" dressed:@"T-shirt" feels:@"happy" with:@[findImg,findImg1,recordImg,recordImg1,mineImg,mineImg1]];
//    [self.rc add:r1];
//     self.dataArray = [self.rc getAll];
//    self.num = [self.rc getNumofRecords];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 90, self.view.bounds.size.width, 50)];
    self.searchBar.placeholder = @"时间/地点/穿搭";
    self.searchBar.delegate = self;
    self.searchBar.searchTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.searchBar];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 140, self.view.bounds.size.width, self.view.bounds.size.height-150 ) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    
    //[self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    //为tableView添加识别向上滑动的手势
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    recognizer.delegate = (id)self;
    [self.tableView addGestureRecognizer:recognizer];
    
}

-(void)viewWillAppear:(BOOL)animated{
    //每次画面要展现时通过RecordController获取当前穿搭记录存储的最新状态
    self.num = [self.rc getNumofRecords];
    self.dataArray = [self.rc getAll];
    
    //[self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    [self.tableView reloadData];
//    [self.tableView reloadData];
}

//代理函数，解决多个手势冲突·
- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer{
    return YES;

}

//代理函数，开启手势识别
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

//手势识别的响应函数
-(void)handleSwipe{
    //进度条
    UIView * bar = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-100, 5, 50)];
    bar.backgroundColor = [UIColor redColor];
    [self.view addSubview:bar];
    //提示文字
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-120, self.view.bounds.size.width, 50)];
    label.text = @"加载中";
    label.textAlignment = UIListContentTextAlignmentCenter;
    [self.view addSubview:label];
    //关键帧动画
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.1 animations: ^{
                // key frame 0
                bar.alpha = 1.0;
                label.alpha = 1.0;
    
            }];
            [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.6 animations: ^{
                //NSLog(@"there");
                bar.frame = CGRectMake(0, self.view.bounds.size.height-100, self.view.bounds.size.width+100, 50);
                bar.alpha = 0;
                label.alpha = 0;
            }];
        } completion:nil];
}





//-(void)viewWillDisappear:(BOOL)animated{
//    [self.view endEditing:YES];
//    [self.tabBarController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //无搜索结果
    if(self.flag == 1 && [self.searchResult count] == 0){
        return 0;
    }
    //不在搜索
    if([self.searchResult count] == 0){
        return self.num;
    }
    //有搜索结果
    else{
        return [self.searchResult count];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        //cell.frame = CGRectMake(0, 10, 10, 10);

    }
    //cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
//    UITableViewCell * cell = [[UITableViewCell alloc]init];
    cell.layer.borderWidth = 1;
    cell.layer.cornerRadius = 10.0;
    cell.textLabel.numberOfLines = 4;
    if([self.searchResult count] == 0){
        cell.textLabel.text = [self.dataArray[indexPath.section]getInfo];
    }
    else{
            cell.textLabel.text = [self.searchResult[indexPath.section]getInfo];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Records * record = self.dataArray[indexPath.section];
    DetailViewController * detail = [[DetailViewController alloc]init:record];

    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromTop;
        
        // 添加动画
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:detail animated:NO];
}

-(void)searchForRecord:(NSString*)text{
    for(NSInteger i = 0;i < self.num;i++){
        if([[self.dataArray[i] getTime] containsString:text] || [[self.dataArray[i] getPlace] containsString:text] || [[self.dataArray[i] getClothes] containsString:text]){
            [self.searchResult addObject:self.dataArray[i]];
        }
    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //设置搜索状态
    if(![self.searchBar.text  isEqual: @""]){
        self.flag = 1;
    }else{
        self.flag = 0;
    }
    
    [self.searchResult removeAllObjects];
    [self searchForRecord:searchText];
    [self.tableView reloadData];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"!!!");
//    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 200, 200)];
//    label1.text = @"!@#!@#!@#!@#!@#!@#!";
//    [self.view addSubview:label1];
//
//    //DrawCyclesView * cicle = [[DrawCyclesView alloc]initWithFrame:CGRectMake(0, 80, 200, 200)];
//    //[self.view addSubview:cicle];
//    UIView * bar = [[UIView alloc]initWithFrame:CGRectMake(0, 80, 50, 20)];
//    bar.backgroundColor = [UIColor redColor];
//    [self.view addSubview:bar];
//
//    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
//        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.6 animations: ^{
//            // key frame 0
//            NSLog(@"here");
//            bar.center = (CGPoint){ 50,  80 };
//
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.4 animations: ^{
//            NSLog(@"there");
//            bar.center = (CGPoint){ 50,  300 };
//            //[bar setHidden:YES];
////            label1.text = @"2222";
////            label1.textColor = [UIColor blueColor];
////            label1.center = (CGPoint){ center.x + 45, center.y + 180 };
//            //circle.cornerRadius = 20.0;
//        }];
//    } completion:nil];
//
//}

//https://blog.csdn.net/wbxiaowangzi/article/details/49585805

@end
