//
//  RecordsController.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/10.
//

#import <Foundation/Foundation.h>
#import "Records.h"
#import "RecordsStorage.h"
NS_ASSUME_NONNULL_BEGIN

@interface RecordsController : NSObject{
    RecordsStorage* rsto;
}
-(id)init;
-(void)add:(Records*)records;
-(void)remove:(Records*)records;
-(NSMutableArray*)getAll;
-(NSUInteger)getNumofRecords;
@end

NS_ASSUME_NONNULL_END
