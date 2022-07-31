//
//  Trousers.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/9/20.
//
#import "Trousers.h"
#import <Foundation/Foundation.h>

@interface Trousers(){
    int leg;// 0-直筒裤 1-宽筒裤 2-紧身裤
}

@end

@implementation Trousers

- (id)initWithColor:(NSString *)_color andLeg:(int)_leg{
    self = [super initWithColor:_color];
    leg = _leg;
    return self;
}

- (BOOL)putOn{
    if([self getCounter] == 0){
        [self setCounter:2];
        return true;
    }
    return false;
}

- (int)getLeg{
    return leg;
}
@end
