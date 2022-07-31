//
//  ViewController.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/30.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UnitViewController* uc = [[UnitViewController alloc]init];
    [self.navigationController setViewControllers:@[uc]];
    
    
    
    
    
//    NSURL * url = [NSURL URLWithString:@"https://hbimg.huabanimg.com/37eccdc1164fb5165712f7bdebb9db6dee47a21c34bb4-HwoXgs_fw658"];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDownloadTask * downloadTask =[session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//    if(error == nil) {
//    NSLog(@"Temporary file =%@",location);
//    NSError *err = nil;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSURL *docsDirURL = [NSURL fileURLWithPath:[docsDir stringByAppendingPathComponent:@"out.zip"]]; if ([fileManager moveItemAtURL:location toURL:docsDirURL error: &err])
//    {
//    NSLog(@"File is saved to =%@",docsDir); } else {
//    NSLog(@"failed to move: %@",[err userInfo]); }
//    } }];
//    [downloadTask resume];
}

- (void)viewWillAppear:(BOOL)animated{
    
}





@end
