//
//  QuestionLoader.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/30.
//

#import "QuestionLoader.h"
@interface QuestionLoader()
@property(strong, nonatomic) NSString * text;//存放获得的响应文本
@end
@implementation QuestionLoader

-(id)init{
    self = [super init];
    questions = [[NSMutableArray alloc]init];
    return self;
}

-(void)loadQuestion{
    //通过一个信号量，使得请求得以同步，即获取到请求之后再执行下面的存储，保证获取到的问题可以顺利地存储
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSURL * url = [NSURL URLWithString:@"http://172.18.178.56:8360/hw3/get_question"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if(error == nil){
            self.text  = [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding];
        }
        dispatch_semaphore_signal(semaphore);
       }];
    [dataTask resume];
    //等待请求任务结束再执行下面的操作
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSString * text = self.text;
    NSString * idStr = @"id";
    NSString * imageStr = @"image";
    NSString * choice1Str = @"choice1";
    NSString * choice2Str = @"choice2";
    NSString * choice3Str = @"choice3";

    NSRange range = [self.text rangeOfString:idStr];
    NSInteger location = range.location;

    NSString * questionID;
    NSString * imageURL;
    NSString * choice1;
    NSString * choice2;
    NSString * choice3;

    NSInteger begin;
    //若当前待搜索的字符串中能找到子串——“id”，说明还有数据，则继续提取
    while([text rangeOfString:idStr].length == 2){
        range = [text rangeOfString:idStr];
        location = range.location;
        //id值的开始位置
        location = location + 4;
        questionID = @"";
        //以逗号为结束符，扫描获取整个id值
        while(true){
            char c = [text characterAtIndex:location];
            if(c == ','){
                break;
            }
            else{
                questionID = [questionID stringByAppendingFormat:@"%c",c];
                location++;
            }
        }

        range = [text rangeOfString:imageStr];
        location = range.location;
        //url的开始位置
        location = location + 8;
        imageURL = @"";
        //以双引号为结束符，扫描获取整个url值
        while(true){
            char c = [text characterAtIndex:location];
            if(c == '"'){
                break;
            }
            else{
                imageURL = [imageURL stringByAppendingFormat:@"%c",c];
                location++;
            }
        }

        range = [text rangeOfString:choice1Str];
        location = range.location;
        //选项1的开始位置
        location = location + 10;
        choice1 = @"";
        begin = location;
        //以双引号为结束符，扫描获取整个选项1的长度，由于选项有中文，因此若像前面一样逐个字符添加会造成乱码
        //因此选择获取选项的长度，然后通过substringWithRange函数直接获取子串
        while(true){
            char c = [text characterAtIndex:location];
            if(c == '"'){
                break;
            }
            else{
                location++;
            }
        }
        choice1 = [text substringWithRange:NSMakeRange(begin, location-begin)];


        range = [text rangeOfString:choice2Str];
        location = range.location;
        location = location + 10;
        choice2 = @"";
        begin = location;
        while(true){
            char c = [text characterAtIndex:location];
            if(c == '"'){
                break;
            }
            else{
                location++;
            }
        }
        choice2 = [text substringWithRange:NSMakeRange(begin, location-begin)];

        range = [text rangeOfString:choice3Str];
        location = range.location;
        location = location + 10;
        choice3 = @"";
        begin = location;
        while(true){
            char c = [text characterAtIndex:location];
            if(c == '"'){
                break;
            }
            else{
                location++;
            }
        }
        choice3 = [text substringWithRange:NSMakeRange(begin, location-begin)];
        //创建新的问题对象
        Question * question = [[Question alloc]init:questionID withQuestionURL:imageURL withChoice1:choice1 withChoice2:choice2 withChoice3:choice3];
        //添加到问题数组中
        [questions addObject:question];
        //截断已经扫描过的部分，进入下一次循环
        text = [text substringFromIndex:location];
    }
}

- (Question*)getQuestion:(NSInteger)num{
    return [questions objectAtIndex:num];
}

-(NSInteger)getQuestionsNum{
    return [questions count];
}
@end
