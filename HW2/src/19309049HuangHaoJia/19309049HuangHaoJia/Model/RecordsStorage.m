//
//  RecordsStorage.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/10.
//

#import "RecordsStorage.h"

@interface RecordsStorage(){
}
-(id)init;
@end

@implementation RecordsStorage
static RecordsStorage* instance;
+(RecordsStorage*)getInstance{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[RecordsStorage alloc]init];
    });
    return instance;
}
-(id)init{
    self = [super init];
    records = [[NSMutableArray alloc]init];
    return self;
}
-(NSUInteger)getNumofRecords{
    return [records count];
}
@end
