//
//  MineViewController.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/8.
//
#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "MineBackgroundView.h"
#import "LoginController.h"
#ifndef MineViewController_h
#define MineViewController_h
@interface MineViewController : UIViewController
-(id)initWithSuper:(UIViewController*)su;
- (void)login:(UserInfo*) user;
- (void)exitLogin;
@end

#endif /* MineViewController_h */
