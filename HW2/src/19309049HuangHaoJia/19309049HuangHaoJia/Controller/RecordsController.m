//
//  RecordsController.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/10.
//

#import "RecordsController.h"

@implementation RecordsController
-(id)init{
    self = [super init];
    rsto = [RecordsStorage getInstance];
    //rsto = [[RecordsStorage alloc]init];
    return self;
}
-(void)add:(Records *)records{
    NSInteger cnt = [rsto->records count];
    if(cnt == 0){
        //NSLog(@"!!123!!");
        [rsto->records addObject:records];
    }
    else{
        if([records.getTime compare:[rsto->records[0] getTime]] == NSOrderedDescending){
            [rsto->records insertObject:records atIndex:0];
        }
        else{
            NSInteger i = 0;
            while(true){
                if([records.getTime compare:[rsto->records[i] getTime]] == NSOrderedDescending || i == cnt-1){
                    break;
                }
                i++;
            }
            if(i == cnt-1){
                [rsto->records insertObject:records atIndex:cnt];
            }
            else{
                [rsto->records insertObject:records atIndex:i];
            }
            
        }
    }
    
//
//
//    else if(cnt == 1){
//        if([records.getTime compare:[rsto->records[0] getTime]] == NSOrderedDescending){
//            NSLog(@"%@",records.getTime);
//            NSLog(@"%@",[rsto->records[0] getTime]);
//            [rsto->records insertObject:records atIndex:0];
//        }
//        else{
//            [rsto->records insertObject:records atIndex:1];
//        }
//
//    }
//    else{
//        for(NSInteger i = 0;i < cnt-1;i++){
//            if([records.getTime compare:[rsto->records[i] getTime]] == NSOrderedDescending && [records.getTime compare:[rsto->records[i+1] getTime]] == NSOrderedAscending){
//                NSLog(@"ASDASDASD");
//                [rsto->records insertObject:records atIndex:i];
//                break;
//            }
//        }
    //}
}
-(void)remove:(Records *)records{
    [rsto->records removeObject:records];
}
-(NSMutableArray*)getAll{
    return rsto->records;
}
-(NSUInteger)getNumofRecords{
    return [rsto getNumofRecords];
}
@end
