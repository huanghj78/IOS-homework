//
//  Judge.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/31.
//

#import <Foundation/Foundation.h>
#import "Question.h"
NS_ASSUME_NONNULL_BEGIN

@interface Judge : NSObject
-(BOOL)judge:(NSString*)ID withChoice:(NSString*)choice;
-(NSString*)getCorrectAnswer:(Question*)q;
@end

NS_ASSUME_NONNULL_END
