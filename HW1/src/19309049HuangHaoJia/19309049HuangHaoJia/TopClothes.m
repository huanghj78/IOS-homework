//
//  TopClothes.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/9/20.
//

#import <Foundation/Foundation.h>
#import "TopClothes.h"

@interface TopClothes(){
    int sleeve;// 0-无袖 1-短袖 2-长袖
}

@end

@implementation TopClothes

- (id)initWithColor:(NSString *)_color andSleeve:(int)_sleeve{
    self = [super initWithColor:_color];
    sleeve = _sleeve;
    return self;
}

- (BOOL)putOn{
    if([self getCounter] == 0){
        [self setCounter:3];
        return true;
    }
    return false;
}

- (int)getSleeve{
    return sleeve;
}
@end
