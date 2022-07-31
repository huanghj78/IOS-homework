//
//  ViewController.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/9.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建tabBar控制器以及三个子页面控制器并对它们进行初始化
    UITabBarController * tabBar = [[UITabBarController alloc] init];
    NSMutableArray * conArray = [[NSMutableArray alloc]init];
    FindViewController * find = [[FindViewController alloc]initWithSuper:self];
    RecordViewController * record = [[RecordViewController alloc]initWithSuper:self];
    MineViewController * mine = [[MineViewController alloc]initWithSuper:self];
    // 设置标题
    find.tabBarItem.title = @"Find";
    record.tabBarItem.title = @"Record";
    mine.tabBarItem.title = @"Mine";
    //将三个子页面添加到tabBar控制器中
    [conArray addObject:find];
    [conArray addObject:record];
    [conArray addObject:mine];
    tabBar.viewControllers = conArray;
    //tabBarItem设置被选中时为红色字体
    [find.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    [record.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    [mine.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    // 保证tabBarItem选中时字体为红色
    tabBar.tabBar.tintColor = [UIColor redColor];
    //添加图片
    UIImage * findImg = [UIImage imageNamed:@"find.jpg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UIImage * findImg1 = [UIImage imageNamed:@"find1.jpg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UIImage * recordImg = [UIImage imageNamed:@"record.jpg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UIImage * recordImg1 = [UIImage imageNamed:@"record1.jpg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UIImage * mineImg = [UIImage imageNamed:@"mine.jpg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UIImage * mineImg1 = [UIImage imageNamed:@"mine1.jpg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    //设置未选中和选中时到icon
    [find.tabBarItem setImage:[findImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [find.tabBarItem setSelectedImage:[findImg1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [record.tabBarItem setImage:[recordImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [record.tabBarItem setSelectedImage:[recordImg1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [mine.tabBarItem setImage:[mineImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [mine.tabBarItem setSelectedImage:[mineImg1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //导航至tabBar，从而可显示出页面
    [self.navigationController setViewControllers:@[tabBar]];
    
    
}


@end
