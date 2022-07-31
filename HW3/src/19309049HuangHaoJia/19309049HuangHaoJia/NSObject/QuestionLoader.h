//
//  QuestionLoader.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/30.
//

#import <Foundation/Foundation.h>
#import "Question.h"
#import "QuestionViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface QuestionLoader : NSObject{
    NSMutableArray * questions;
}

- (void)loadQuestion;
- (Question*)getQuestion:(NSInteger)num;
-(NSInteger)getQuestionsNum;
@end

NS_ASSUME_NONNULL_END
