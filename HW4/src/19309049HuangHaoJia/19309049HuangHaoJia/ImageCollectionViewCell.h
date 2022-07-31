//
//  ImageCollectionViewCell.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/12/3.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN
@class ViewController;
@interface ImageCollectionViewCell : UICollectionViewCell
- (void) setController:(nonnull ViewController*)controller;
- (void) setProperty:(nonnull UIImage*) image;
@end

NS_ASSUME_NONNULL_END
