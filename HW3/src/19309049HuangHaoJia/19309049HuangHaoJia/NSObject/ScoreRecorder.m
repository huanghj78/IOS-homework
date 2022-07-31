//
//  ScoreRecorder.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/31.
//

#import "ScoreRecorder.h"

@implementation ScoreRecorder

-(id)init{
    self = [super init];
    score = 0;
    records = [[NSMutableArray alloc]init];
    return self;
}

-(void)record:(NSInteger)result{
    //传入的result为0或1，0表示错误，1表示正确
    score = score + result;
    if(result == 1){
        [records addObject:@"1"];
    }
    else{
        [records addObject:@"0"];
    }
    
}
-(NSInteger)getScore{
    return  score;
}
-(NSMutableArray*)getRecords{
    return records;
}
@end
