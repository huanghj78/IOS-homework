//
//  DetailViewController.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/10.
//
#import <Foundation/Foundation.h>
#import "DetailViewController.h"
@interface DetailViewController()
@property(strong,nonatomic)NSArray * photoData;//存储由FindViewController传进来的图片
@property(strong,nonatomic)NSMutableArray * imageViews;//存储用于显示图片的UIImageView
@end
@implementation DetailViewController

-(id)init:(Records *)_record {
    self = [super init];
    record = _record;
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"详细";
    //显示穿搭信息
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height/3)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"\t时间：%@\n\t地点：%@\n\t穿搭：%@\n\n\n\t心得：%@\n",record.getTime,record.getPlace,record.getClothes,record.getFeel];
    label.numberOfLines = 20;
    [self.view addSubview:label];
    
    self.photoData = record.getPhotos;
    NSInteger count = self.photoData.count;
    self.imageViews = [[NSMutableArray alloc]init];
    //图片宽度
    int width = (self.view.bounds.size.width - 40)/3;
    //根据图片数量新建UIImageView用于显示图片
    if(count <= 3){
        for (NSInteger i = 0; i < count; i++) {
            UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(10*(i+1)+width*i, self.view.bounds.size.height - 2*width - 100, width, width)];
            iv.backgroundColor = [UIColor redColor];
            [self.imageViews addObject:iv];
        }
    }
    else{
        for (NSInteger i = 0; i < 3; i++) {
            UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(10*(i+1)+width*i, self.view.bounds.size.height - 2*width - 100, width, width)];
            [self.imageViews addObject:iv];
        }
        for (NSInteger i = 0; i < count-3; i++) {
            UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(10*(i+1)+width*i, self.view.bounds.size.height  - width - 50, width, width)];
            [self.imageViews addObject:iv];
        }
    }
    //在已经创建好的UIImageView上显示图片
    for (NSInteger i = 0; i < count; i++) {
        [self.imageViews[i] setImage:self.photoData[i]];
        [self.view addSubview:self.imageViews[i]];
    }
    
}


@end
