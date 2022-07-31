//
//  PhotoCellCollectionViewCell.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/13.
//

#import <UIKit/UIKit.h>
#import "RecordViewController.h"
NS_ASSUME_NONNULL_BEGIN

@class RecordViewController;
@interface PhotoCell : UICollectionViewCell

- (void) setController:(nonnull RecordViewController*)controller;
- (void) setProperty:(nonnull UIImage*) image1 with:(nullable UIImage*)image2 with:(nullable UIImage*) image3 canClick:(NSInteger) index;

@end

NS_ASSUME_NONNULL_END
