//
//  Question.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Question : NSObject{
    NSString* questionID;//题目id
    UIImage * question;//题目图片
    NSString * questionURL;//图片的url
    NSMutableArray* choices;//存放选项的数组
}
-(id)init:(NSString*) _questionID withQuestionURL:(NSString*)_questionURL withChoice1:(NSString*) _choice1 withChoice2:(NSString*)_choice2 withChoice3:(NSString*)_choice3;
-(UIImage*)getQuestion;
-(NSString*)getChoice:(int)num;
-(NSString*)getID;
-(NSMutableArray*)getChoiceList;
@end

NS_ASSUME_NONNULL_END
