//
//  UserInfo.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/14.
//

#import "UserInfo.h"

@implementation UserInfo

+(UserInfo*) construct:(NSString*)name with:(NSString*) password {
    UserInfo* userinfo = [UserInfo alloc];
    userinfo.name = name;
    userinfo.password = password;
    return userinfo;
}

@end
