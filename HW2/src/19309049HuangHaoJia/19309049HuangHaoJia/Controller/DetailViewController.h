//
//  DetailViewController.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Records.h"
#import "PhotoCellCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController{
    Records * record;
}
-(id)init:(Records *)_record;
@end

NS_ASSUME_NONNULL_END
