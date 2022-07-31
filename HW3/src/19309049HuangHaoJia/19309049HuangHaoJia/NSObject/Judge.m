//
//  Judge.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/31.
//

#import "Judge.h"
@interface Judge()
@property(strong, nonatomic) NSString * text;//存放响应
@end
@implementation Judge

//判断选项是否正确
-(BOOL)judge:(NSString*)ID withChoice:(NSString*)choice{
    //应用信号量同步请求操作
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSURL * url = [NSURL URLWithString:@"http://172.18.178.56:8360/hw3/query"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    //请求的数据
    NSDictionary *dic = @{@"number": ID, @"choice":choice};
    NSError *error = nil;
    //转换为json格式
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [urlRequest setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil) {
            //将获取到的响应转为字符串
            self.text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        }
        dispatch_semaphore_signal(semaphore);
    }];
    [dataTask resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //寻找其中是否有带true的子串，若有则返回true，否则返回false
    NSRange range = [self.text rangeOfString:@"true"];
    NSInteger len = range.length;
    if(len > 0){
        return true;
    }
    return false;
}
//获取传入的题目的正确答案
-(NSString*)getCorrectAnswer:(Question*)q{
    NSString* ID = [q getID];
    NSMutableArray * choices = [q getChoiceList];
    //遍历选项，逐个尝试，得出正确结果
    for(NSInteger i = 0;i < [choices count];++i){
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSURL * url = [NSURL URLWithString:@"http://172.18.178.56:8360/hw3/query"];
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod:@"POST"];
        
        NSDictionary *dic = @{@"number": ID, @"choice":[choices objectAtIndex:i]};
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [urlRequest setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSessionDataTask * dataTask =[[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                self.text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            }
            dispatch_semaphore_signal(semaphore);
        }];
        [dataTask resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSRange range = [self.text rangeOfString:@"true"];
        NSInteger len = range.length;
        //若有true子串，说明已经找到正确选项
        if(len > 0){
            //返回对应的选项
            return [choices objectAtIndex:i];
        }
    }
    return nil;
}
@end
