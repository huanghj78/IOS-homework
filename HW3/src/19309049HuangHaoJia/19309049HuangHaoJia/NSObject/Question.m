//
//  Question.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/30.
//

#import "Question.h"

@implementation Question
-(id)init:(NSString*) _questionID withQuestionURL:(NSString*)_questionURL withChoice1:(NSString*) _choice1 withChoice2:(NSString*)_choice2 withChoice3:(NSString*)_choice3{
    self = [super init];
    choices = [[NSMutableArray alloc]init];
    question = [[UIImage alloc]init];
    questionID = _questionID;
    [choices addObject:_choice1];
    [choices addObject:_choice2];
    [choices addObject:_choice3];
    questionURL = _questionURL;
    //通过url获取图片
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:questionURL]];
    question = [UIImage imageWithData:data];
    return self;
}

-(UIImage*)getQuestion{
    return question;
}

-(NSString*)getChoice:(int)num{
    return [choices objectAtIndex:num];
}

-(NSString*)getID{
    return questionID;
}

-(NSMutableArray*)getChoiceList{
    return choices;
}
@end
