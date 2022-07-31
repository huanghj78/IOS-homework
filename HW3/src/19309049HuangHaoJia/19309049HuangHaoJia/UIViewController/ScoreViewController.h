//
//  ScoreViewController.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/31.
//

#import <UIKit/UIKit.h>
#import "ScoreRecorder.h"
#import "UnitViewController.h"
NS_ASSUME_NONNULL_BEGIN
@class UnitViewController;
@interface ScoreViewController : UIViewController
-(id)initWithRecorder:(ScoreRecorder*)r andUnitViewController:(UnitViewController*)uc;
@end

NS_ASSUME_NONNULL_END
