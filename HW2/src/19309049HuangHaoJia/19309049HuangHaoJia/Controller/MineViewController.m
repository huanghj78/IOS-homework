//
//  MineViewController.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/8.
//

#import <Foundation/Foundation.h>
#import "MineViewController.h"
@interface MineViewController ()
@property(strong, nonatomic)UIViewController * su;//父视图控制器
@property(strong, nonatomic) UserInfo* user;//用户信息
@property(strong, nonatomic) UIView* circleView;//圆形视图
@property(strong, nonatomic) UILabel* loginLabel;//登录提示文字
@property(strong, nonatomic) MineBackgroundView* bgView;//背景
@property(strong, nonatomic) UIImageView* uiView;//存放头像图片
@property(strong, nonatomic) UILabel* uitf;//登录之后显示用户信息
@property(strong, nonatomic) UILabel* about;//“关于”
@property(strong, nonatomic) UILabel* aboutdetail;//关于的信息
@property(strong, nonatomic) UIButton *logoutButton;//退出按钮
@end

@implementation MineViewController
-(id)initWithSuper:(UIViewController*)su{
    self = [super init];
    self.su = su;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.su.title = @"我的";
    self.title = @"Mine";
    //[self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    self.title = @"Mine";
    //若当前无用户信息，即为未登录状态
    if(self.user == nil) {
        if(self.bgView == nil) {
            self.bgView = [[MineBackgroundView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            [self.view addSubview:self.bgView];
        }
        //移除用户头像视图组件
        if(self.uiView != nil) {
            [self.uiView removeFromSuperview]; self.uiView = nil;
            [self.uitf removeFromSuperview]; self.uitf = nil;
            [self.about removeFromSuperview]; self.about = nil;
            [self.aboutdetail removeFromSuperview]; self.aboutdetail = nil;
            [self.logoutButton removeFromSuperview]; self.logoutButton = nil;
        }
        //加载圆形视图
        if(self.circleView == nil) {
            self.circleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,200)];
            self.circleView.center = self.view.center;
            self.circleView.alpha = 0.5;
            self.circleView.layer.cornerRadius = 100;
            self.circleView.backgroundColor = [UIColor clearColor];
            self.circleView.layer.borderColor = [UIColor blueColor].CGColor;
            self.circleView.layer.borderWidth = 3;
            //添加点击识别手势
            UIGestureRecognizer* clickLogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goLogin)];
            [self.circleView addGestureRecognizer:clickLogin];
            [self.view addSubview:self.circleView];
            self.loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 58)];
            self.loginLabel.center = self.view.center;
            self.loginLabel.text = @"登录";
            self.loginLabel.font = [UIFont systemFontOfSize:28];
            [self.view addSubview:self.loginLabel];
        }
    } else {//若为登录状态
        //移除圆形视图
        if(self.circleView != nil) {
            [self.circleView removeFromSuperview]; self.circleView = nil;
            [self.loginLabel removeFromSuperview]; self.loginLabel = nil;
            [self.bgView removeFromSuperview]; self.bgView = nil;
        }
        //加载用户信息
        if(self.uiView == nil) {
            NSString* image = @"picture.jpeg";
            UIImage* uiImage = [UIImage imageNamed:image inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
            self.uiView = [[UIImageView alloc] initWithImage:uiImage];
            self.uiView.frame = CGRectMake(self.view.center.x / 2, 100, 200, 200);
            self.uiView.layer.cornerRadius = 100;
            self.uiView.layer.masksToBounds = YES;
            [self.view addSubview:self.uiView];
            
            NSString* username = [self user].name;
            self.uitf = [[UILabel alloc] initWithFrame:CGRectMake(65, 350, 245, 80)];
            self.uitf.layer.borderColor = [UIColor systemBlueColor].CGColor;
            self.uitf.layer.borderWidth = 1;
            
            [self.uitf setNumberOfLines:3];
            self.uitf.text = [[@" 用户名：" stringByAppendingString:username] stringByAppendingString:@"\n 邮箱：12345678910@qq.com\n 电话：12345678910"];
            self.uitf.layer.cornerRadius = 10.0;
            [self.view addSubview:self.uitf];
            
            self.about = [[UILabel alloc] initWithFrame:CGRectMake(40, 450, 100, 30)];
            self.about.text = @"关于：";
            [self.view addSubview:self.about];
            
            self.aboutdetail = [[UILabel alloc] initWithFrame:CGRectMake(65, 480, 245, 170)];
            self.aboutdetail.layer.borderColor = [UIColor systemBlueColor].CGColor;
            self.aboutdetail.layer.borderWidth = 1;
            [self.aboutdetail setNumberOfLines:9];
            self.aboutdetail.layer.cornerRadius = 10.0;
            self.aboutdetail.text = @" 版本:\n\n 隐私和Cookie:\n\n 清除缓存:\n\n 同步:";
            [self.view addSubview:self.aboutdetail];
            
            self.logoutButton= [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [self.logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
            [self.logoutButton setFrame:CGRectMake(2*self.view.bounds.size.width / 5, self.view.bounds.size.height - 180, self.view.bounds.size.width / 5, 40)];
            [self.logoutButton setTitle:@"登出" forState:UIControlStateNormal];
            [self.logoutButton setExclusiveTouch:YES];
            self.logoutButton.layer.borderWidth = 1;
            self.logoutButton.layer.cornerRadius = 10.0;

            [self.view addSubview:self.logoutButton];
        }
        
    }
}

//跳转至登录页面
- (void)goLogin {
    LoginController* lc = [[LoginController alloc] initWithSuper:self];
    [self.navigationController pushViewController:lc animated:NO];
}

//用户登录
- (void)login:(UserInfo*) user {
    self.user = user;
}
//移除登录页面
- (void)exitLogin {
    [self.navigationController popViewControllerAnimated:YES];
    [self viewWillAppear:YES];
}
//用户退出
- (void)logout {
    self.user = nil;
    [self viewWillAppear:YES];
}
@end
