//
//  ImageCollectionViewCell.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/12/3.
//

#import "ImageCollectionViewCell.h"

@interface ImageCollectionViewCell()
@property(strong, nonatomic) ViewController * vc;
@property(strong, nonatomic) UIImageView * iv;
@end

@implementation ImageCollectionViewCell
- (void) setController:(nonnull ViewController*)controller{
    self.vc = controller;
}

- (void) setProperty:(nonnull UIImage*) image{
    self.iv = [[UIImageView alloc] initWithImage:image];
    self.iv.frame = CGRectMake(0, 0, self.bounds.size.width, 200);
    self.iv.layer.masksToBounds = YES;
    [self addSubview:self.iv];
}


@end


