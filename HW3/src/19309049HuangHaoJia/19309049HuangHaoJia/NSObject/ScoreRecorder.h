//
//  ScoreRecorder.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScoreRecorder : NSObject{
    NSInteger score;
    NSMutableArray* records;
}
-(void)record:(NSInteger)result;
-(NSInteger)getScore;
-(NSMutableArray*)getRecords;
@end

NS_ASSUME_NONNULL_END
