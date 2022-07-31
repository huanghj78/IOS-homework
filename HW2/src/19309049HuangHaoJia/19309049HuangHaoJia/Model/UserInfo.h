//
//  UserInfo.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject

@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) NSString* password;

+ (UserInfo*) construct:(NSString*)name with:(NSString*) password;

@end

NS_ASSUME_NONNULL_END
