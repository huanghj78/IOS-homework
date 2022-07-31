//
//  Records.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/10.
//

#import "Records.h"

@interface Records(){

}

@end

@implementation Records
-(id)init:(NSString *)_time at:(NSString *)_place dressed:(NSString *)_clothes feels:(NSString *)_feel with:(NSArray *)_photos{
    self = [super init];
    time = _time;
    place = _place;
    clothes = _clothes;
    feel = _feel;
    photos = _photos;
    return self;
}
-(NSString*)getTime{
    return time;
}
-(NSString*)getInfo{
    return [[NSString alloc]initWithFormat:@"日期：%@\n地点：%@\n穿搭：%@\n",time,place,clothes];
}
-(NSString*)getPlace{
    return place;
}

-(NSString*)getClothes{
    return clothes;
}

-(NSString*)getFeel{
    return feel;
}
-(NSArray*)getPhotos{
    return  photos;
}
@end
