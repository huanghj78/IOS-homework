//
//  Clothes.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/9/11.
//

#import <Foundation/Foundation.h>
#import "Clothes.h"

@interface Clothes(){
    NSString* color; // 衣服颜色
    int counter; // 计数器，记录下衣物剩下冷却时间
}

@end

@implementation Clothes

- (id)initWithColor:(NSString *)_color{
    color = _color;
    counter = 0;
    return self;
}

- (void) setColor:(NSString *)_color{
    color = _color;
}

- (NSString*) getColor{
    return color;
}

- (int) getCounter{
    return counter;
}

- (void)setCounter:(int)_counter{
    counter = _counter;
}

- (void)calCounter{
    if(counter != 0){
        counter--;
    }
}

- (BOOL)putOn{
    return false;
}

@end





