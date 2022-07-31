//
//  TopClothes.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/9/20.
//

#ifndef TopClothes_h
#define TopClothes_h

#import "Clothes.h"

// 上衣类
@interface TopClothes : Clothes{
    
}
- (id)initWithColor:(NSString *)_color andSleeve:(int)_sleeve;
- (int)getSleeve;
@end

#endif /* TopClothes_h */
