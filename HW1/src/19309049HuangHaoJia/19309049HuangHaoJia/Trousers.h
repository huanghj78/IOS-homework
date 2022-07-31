//
//  Trousers.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/9/20.
//

#ifndef Trousers_h
#define Trousers_h
#import "Clothes.h"

// 裤子类
@interface Trousers : Clothes{
    
}
- (id)initWithColor:(NSString *)_color andLeg:(int)_leg;
- (int)getLeg;
@end

#endif /* Trousers_h */
