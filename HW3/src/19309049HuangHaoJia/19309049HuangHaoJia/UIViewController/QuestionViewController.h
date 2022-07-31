//
//  QuestionViewController.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/30.
//

#import <UIKit/UIKit.h>
#import "QuestionLoader.h"
#import "Judge.h"
#import "ResultView.h"
#import "ScoreViewController.h"
#import "ScoreRecorder.h"
#import "UnitViewController.h"
NS_ASSUME_NONNULL_BEGIN
@class UnitViewController;
@interface QuestionViewController : UIViewController
-(id)initWithUnitViewController:(UnitViewController*) uc;
@end

NS_ASSUME_NONNULL_END
