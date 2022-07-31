//
//  main.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/9/11.
//

#import <UIKit/UIKit.h>
#import "Solution.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        // 初始化Solution对象
        Solution * s = [[Solution alloc] _init];
        // 随机搭配
        [s match];
        // 输出最高分
        [s highestScore];
    }
    return 0;
}


