//
//  PhotoCellCollectionViewCell.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/13.
//
#import "PhotoCellCollectionViewCell.h"

@interface PhotoCell ()

@property(strong, nonatomic) UIImageView* iv1;
@property(strong, nonatomic) UIImageView* iv2;
@property(strong, nonatomic) UIImageView* iv3;
@property(strong, nonatomic) UIButton* but;
@property(strong, nonatomic) RecordViewController* cc;

@end

@implementation PhotoCell

- (void) setController:(RecordViewController*)controller {
    self.cc = controller;
}

- (void) setProperty:(nonnull UIImage*) image1 with:(nullable UIImage*)image2 with:(nullable UIImage*) image3 canClick:(NSInteger) index {
    self.iv1 = [[UIImageView alloc] initWithImage:image1];
    self.iv1.frame = CGRectMake(20, 0, 90, 90);
    self.iv1.layer.masksToBounds = YES;
    if(index == 1) {
        UIGestureRecognizer* addPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewPicture)];
        [self.iv1 addGestureRecognizer:addPicture];
        self.iv1.userInteractionEnabled = true;
    }
    
    [self addSubview:self.iv1];
    
    if(image2 != nil) {
        self.iv2 = [[UIImageView alloc] initWithImage:image2];
        self.iv2.frame = CGRectMake(130, 0, 90, 90);
        self.iv2.layer.masksToBounds = YES;
        
        if(index == 2) {
            UIGestureRecognizer* addPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewPicture)];
            [self.iv2 addGestureRecognizer:addPicture];
            self.iv2.userInteractionEnabled = true;
        }
        
        [self addSubview:self.iv2];
    }
    if(image3 != nil) {
        self.iv3 = [[UIImageView alloc] initWithImage:image3];
        self.iv3.frame = CGRectMake(240, 0, 90, 90);
        self.iv3.layer.masksToBounds = YES;
        
        if(index == 3) {
            UIGestureRecognizer* addPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewPicture)];
            [self.iv3 addGestureRecognizer:addPicture];
            self.iv3.userInteractionEnabled = true;
        }
        
        [self addSubview:self.iv3];
    }
}


- (void) addNewPicture {
    [self.cc openPickerPickController];
}

@end
