//
//  Solution.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/9/11.
//

#ifndef Solution_h
#define Solution_h

#import <Foundation/Foundation.h>
#import "TopClothes.h"
#import "Trousers.h"
@interface Solution : NSObject{

}
// 初始化函数
- (id)_init;
// 随机搭配
- (void)match;
// 输出最高分对应的搭配
- (void)highestScore;
// 输出特定上衣和裤子对应的信息
- (void)outPutTopClothes:(TopClothes *)tc andTrousers:(Trousers *)ts;
@end

#endif /* Solution_h */
