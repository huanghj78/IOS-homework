//
//  RecordsStorage.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/10.
//

#import <Foundation/Foundation.h>
#import "Records.h"
NS_ASSUME_NONNULL_BEGIN

@interface RecordsStorage : NSObject{
    @public NSMutableArray* records;
}
+(RecordsStorage*)getInstance;
-(NSUInteger)getNumofRecords;
@end


NS_ASSUME_NONNULL_END
