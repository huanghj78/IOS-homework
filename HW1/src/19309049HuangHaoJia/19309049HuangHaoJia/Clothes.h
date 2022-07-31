//
//  Clothes.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/9/11.
//

#ifndef Clothes_h
#define Clothes_h

#import <Foundation/Foundation.h>


@interface Clothes : NSObject{

}

- (id)initWithColor:(NSString*)_color;
- (void) setColor:(NSString*) color;
- (NSString*) getColor;
- (void)setCounter:(int)_counter;
- (int) getCounter;
- (void) calCounter;  // 更新剩余冷却时间
- (BOOL)putOn; // 尝试将衣服穿上
@end

#endif /* Clothes_h */
