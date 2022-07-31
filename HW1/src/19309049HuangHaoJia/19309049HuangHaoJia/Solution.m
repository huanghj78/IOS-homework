//
//  Solution.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/9/11.
//

#import <Foundation/Foundation.h>
#import "Solution.h"
#import "Clothes.h"
#import "TopClothes.h"
#import "Trousers.h"

@interface Solution(){
    int N;// 上衣数量
    int M;// 裤子数量
    int HighestScore;// 最高搭配分
    int HighestScoreDay;// 最高搭配分对应的日期
    NSString* HighestScoreTopClothes;// 最高分对应的上衣颜色
    NSString* HighestScoreTrousers;// 最高分对应的裤子颜色
    NSMutableArray *TopClothesList;// 上衣列表
    NSMutableArray *TrousersList;// 裤子列表
    NSMutableDictionary *ScoreMap;// 搭配分数表
}

@end


@implementation Solution

- (id)_init{
    N = 4;
    M = 5;
    HighestScore = 0;
    // 定义上衣信息
    TopClothesList = [[NSMutableArray alloc] init];
    [TopClothesList addObject:[[TopClothes alloc]initWithColor:@"Yellow" andSleeve:1]];
    [TopClothesList addObject:[[TopClothes alloc]initWithColor:@"Blue"andSleeve:0]];
    [TopClothesList addObject:[[TopClothes alloc]initWithColor:@"Black"andSleeve:2]];
    [TopClothesList addObject:[[TopClothes alloc]initWithColor:@"White"andSleeve:0]];
    // 定义裤子信息
    TrousersList = [[NSMutableArray alloc] init];
    [TrousersList addObject:[[Trousers alloc]initWithColor:@"Black"andLeg:1]];
    [TrousersList addObject:[[Trousers alloc]initWithColor:@"White"andLeg:0]];
    [TrousersList addObject:[[Trousers alloc]initWithColor:@"Gray"andLeg:1]];
    [TrousersList addObject:[[Trousers alloc]initWithColor:@"Yellow"andLeg:2]];
    [TrousersList addObject:[[Trousers alloc]initWithColor:@"Red"andLeg:2]];
    // 定义搭配分数
    ScoreMap = [[NSMutableDictionary alloc] init];
    [ScoreMap setObject:@"50" forKey:@"YellowBlack"];
    [ScoreMap setObject:@"60" forKey:@"YellowWhite"];
    [ScoreMap setObject:@"50" forKey:@"YellowGray"];
    [ScoreMap setObject:@"20" forKey:@"YellowYellow"];
    [ScoreMap setObject:@"30" forKey:@"YellowRed"];
    
    [ScoreMap setObject:@"40" forKey:@"BlueBlack"];
    [ScoreMap setObject:@"60" forKey:@"BlueWhite"];
    [ScoreMap setObject:@"60" forKey:@"BlueGray"];
    [ScoreMap setObject:@"20" forKey:@"BlueYellow"];
    [ScoreMap setObject:@"10" forKey:@"BlueRed"];
    
    [ScoreMap setObject:@"30" forKey:@"BlackBlack"];
    [ScoreMap setObject:@"80" forKey:@"BlackWhite"];
    [ScoreMap setObject:@"40" forKey:@"BlackGray"];
    [ScoreMap setObject:@"70" forKey:@"BlackYellow"];
    [ScoreMap setObject:@"30" forKey:@"BlackRed"];
    
    [ScoreMap setObject:@"80" forKey:@"WhiteBlack"];
    [ScoreMap setObject:@"70" forKey:@"WhiteWhite"];
    [ScoreMap setObject:@"50" forKey:@"WhiteGray"];
    [ScoreMap setObject:@"80" forKey:@"WhiteYellow"];
    [ScoreMap setObject:@"50" forKey:@"WhiteRed"];

    return self;
}


- (void)highestScore{
    NSLog(@"\nHighest score:%d\nDay: %d\n上衣颜色:%@\n裤子颜色:%@",HighestScore,HighestScoreDay,HighestScoreTopClothes,HighestScoreTrousers);
}

- (void)outPutTopClothes:(TopClothes *)tc andTrousers:(Trousers *)ts{
    int sleeve = [tc getSleeve];
    int leg = [ts getLeg];
    NSString* sleeveStr;
    NSString* legStr;
    switch (sleeve) {
        case 0:
            sleeveStr = @"无袖";
            break;
        case 1:
            sleeveStr = @"短袖";
            break;
        case 2:
            sleeveStr = @"长袖";
            break;
        default:
            break;
    }
    switch (leg) {
        case 0:
            legStr = @"直筒";
            break;
        case 1:
            legStr = @"宽筒";
            break;
        case 2:
            legStr = @"紧身";
            break;
        default:
            break;
    }
    NSLog(@"\n上衣:\n颜色:%@ 款式:%@ \n裤子:\n颜色:%@ 款式:%@",[tc getColor],sleeveStr,[ts getColor],legStr);
}

- (void)match{
    NSString *str;
    int CurScore = 0;
    TopClothes* tc;
    Trousers* ts;
    NSString* TopClothesColor;
    NSString* TrousersColor;
    // 七天的搭配
    for(int i = 0;i < 7;i++){
        while(1){
            // 随机挑选一件上衣
            int top = (arc4random() % N);
            tc = [TopClothesList objectAtIndex:top];
            if([tc putOn]){
                TopClothesColor = [tc getColor];
                break;
            }
        }
        while(1){
            // 随机挑选一件裤子
            int trousers = (arc4random() % M);
            ts = [TrousersList objectAtIndex:trousers];
            if([ts putOn]){
                TrousersColor = [ts getColor];
                break;
            }
        }
        // 找到对应的搭配分数
        str = [ScoreMap objectForKey:[TopClothesColor stringByAppendingString:TrousersColor]];
        CurScore = [str intValue];
        // 更新最高分
        if(CurScore > HighestScore){
            HighestScore = CurScore;
            HighestScoreDay = i+1;
            HighestScoreTopClothes = TopClothesColor;
            HighestScoreTrousers = TrousersColor;
        }
        // 输出搭配信息
        NSLog(@"\nDay %d\n",i+1);
        [self outPutTopClothes:tc andTrousers:ts];
        NSLog(@"Score:%d\n\n",CurScore);
        // 更新上衣和裤子的冷却时间
        for(TopClothes* tc in TopClothesList){
            [tc calCounter];
        }
        for(Trousers* ts in TrousersList){
            [ts calCounter];
        }
    }
}

@end
