//
//  LoginController.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/14.
//

#import "LoginController.h"

@implementation NewTextField

static CGFloat leftMargin = 5;

- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds.origin.x += leftMargin;

    return bounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds.origin.x += leftMargin;

    return bounds;
}
@end

@interface LoginController ()
@property(strong, nonatomic) MineViewController* su;
@property(strong, nonatomic) UILabel* ul;
@property(strong, nonatomic) UILabel* pl;
@property(strong, nonatomic) NewTextField* username;
@property(strong, nonatomic) NewTextField* password;
@end

@implementation LoginController

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"用户登录";
    
    self.ul = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 200, 30)];
    self.ul.text = @"用户名：";
    self.ul.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.ul];
    
    self.username = [[NewTextField alloc] initWithFrame:CGRectMake(80, 100, 250, 30)];
    self.username.placeholder = @"username";
    self.username.layer.borderWidth = 1;
    self.username.layer.borderColor = [UIColor systemBlueColor].CGColor;
    [self.view addSubview:self.username];
    
    self.pl = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 200, 30)];
    self.pl.text = @"密码：";
    self.pl.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.pl];
    
    self.password = [[NewTextField alloc] initWithFrame:CGRectMake(80, 150, 250, 30)];
    self.password.placeholder = @"password";
    [self.password setSecureTextEntry:YES];
    self.password.layer.borderWidth = 1;
    self.password.layer.borderColor = [UIColor systemBlueColor].CGColor;
    
    [self.view addSubview:self.password];
    
    UIButton *but= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.layer.borderWidth = 1;
    but.layer.cornerRadius = 10.0;
    [but addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [but setFrame:CGRectMake(2*self.view.bounds.size.width/5,self.view.bounds.size.height/2 , self.view.bounds.size.width/5, 40)];
    [but setTitle:@"登录" forState:UIControlStateNormal];
    [but setExclusiveTouch:YES];

    [self.view addSubview:but];
}
//未输入用户名和密码时不能登录
-(BOOL)check{
    if([self.username.text isEqualToString:@""] || [self.password.text isEqualToString:@""]){
        return false;
    }
    return true;
}
- (void) loginButtonClicked:(UIButton*)sender {
    if(![self check]){
        return ;
    }
    [self.su login: [UserInfo construct:self.username.text with:self.password.text]];
    [self.su exitLogin];
}

- (id) initWithSuper:(MineViewController* ) su {
    self = [super init];
    self.su = su;
    return self;
}

@end
