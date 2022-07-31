//
//  ViewController.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/12/2.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(strong, nonatomic) UIButton * loadButton;             //加载按钮
@property(strong, nonatomic) UIButton * clearButton;            //清空按钮
@property(strong, nonatomic) UIButton * deleteButton;           //删除缓存按钮
@property(strong, nonatomic) UIBarButtonItem * loadItem;        //加载按钮的工具栏Item
@property(strong, nonatomic) UIBarButtonItem * clearItem;       //清空按钮的工具栏Item
@property(strong, nonatomic) UIBarButtonItem * deleteItem;      //删除按钮的工具栏Item
@property(strong, nonatomic) UIBarButtonItem * flexibleSpace;   //用于调整工具栏Item
@property(strong, nonatomic) NSArray * itemArray;               //存放item的数组
@property(strong, nonatomic) UICollectionView * collectionView;
@property(strong, nonatomic) NSMutableArray * imageArray;       //存放图片
@property(strong, nonatomic) NSMutableArray * urlArray;         //存放图片的url
@property(strong, nonatomic) NSFileManager * fileManager;
@property(strong, nonatomic) NSString * cachePath;
@property(strong, nonatomic) UIImage * loadingImage;
@property(strong, nonatomic) NSMutableArray * localImgPath;     //存放在cache中的图片的文件路径
@property(nonatomic) NSInteger imageNum;                        //图片总数

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置标题
    self.title = @"Pictures";
    //加载时需要的图片
    self.loadingImage = [UIImage imageNamed:@"load.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    //数组初始化
    self.imageArray = [[NSMutableArray alloc]init];
    self.urlArray = [[NSMutableArray alloc]init];
    self.localImgPath = [[NSMutableArray alloc]init];
    
    //初始化三个按钮
    self.loadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.loadButton addTarget:self action:@selector(loadBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.loadButton setFrame:CGRectMake(20, 600, 100, 35)];
    [self.loadButton setTitle:@"加载" forState:UIControlStateNormal];
    [self.loadButton setBackgroundColor:[UIColor colorWithRed:0 green:0.6 blue:0 alpha:1]];
    [self.loadButton setTintColor:[UIColor clearColor]];
    [self.loadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loadButton.layer.cornerRadius = 10;
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.clearButton addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.clearButton setFrame:CGRectMake(20, 600, 100, 35)];
    [self.clearButton setTitle:@"清空" forState:UIControlStateNormal];
    [self.clearButton setBackgroundColor:[UIColor colorWithRed:0 green:0.6 blue:0 alpha:1]];
    [self.clearButton setTintColor:[UIColor clearColor]];
    [self.clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.clearButton.layer.cornerRadius = 10;
    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.deleteButton addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteButton setFrame:CGRectMake(20, 600, 100, 35)];
    [self.deleteButton setTitle:@"删除缓存" forState:UIControlStateNormal];
    [self.deleteButton setBackgroundColor:[UIColor colorWithRed:0 green:0.6 blue:0 alpha:1]];
    [self.deleteButton setTintColor:[UIColor clearColor]];
    [self.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.deleteButton.layer.cornerRadius = 10;
    
    self.loadItem = [[UIBarButtonItem alloc]initWithCustomView:self.loadButton];
    self.clearItem = [[UIBarButtonItem alloc]initWithCustomView:self.clearButton];
    self.deleteItem = [[UIBarButtonItem alloc]initWithCustomView:self.deleteButton];
    //用于让三个按钮自动布局
    self.flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    self.itemArray = [[NSArray alloc]initWithObjects:self.flexibleSpace,self.loadItem,self.flexibleSpace,self.clearItem,self.flexibleSpace,self.deleteItem,self.flexibleSpace, nil];
    [self setToolbarItems:self.itemArray];
    //初始UICollectionView
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(345, 100);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"imagecell"];
    [self.view addSubview:self.collectionView];
    //为Collection添加点击识别手势
    UIGestureRecognizer* touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editEnding)];
    [self.collectionView addGestureRecognizer:touch];
    self.collectionView.userInteractionEnabled = true;
    
    //存放图片url
    self.urlArray = [[NSMutableArray alloc]init];
    NSString * url1 = @"https://hbimg.huabanimg.com/039fe67f0b83b99605374db04fcd4410d10ef135182f2-TJ5VQC_fw658";
    NSString * url2 = @"https://hbimg.huabanimg.com/ad5ef2f1ea4c71ef333c8bcd936102077e6d8ddfe471-lJHmP7_fw658";
    NSString * url3 = @"https://hbimg.huabanimg.com/66ba2e842fbb485b6a155bfb742e73110e745c68612b-4YubTV_fw658";
    NSString * url4 = @"https://hbimg.huabanimg.com/050ad49cece305f1ecfcac4cb3cf301ce7b894dd1d5ea-UN9FgQ_fw658";
    NSString * url5 = @"https://hbimg.huabanimg.com/6a94d8532a265d11b183fdeab7782907d71e90e4ad0c-Q3mC3J_fw658";
    [self.urlArray addObject:url1];
    [self.urlArray addObject:url2];
    [self.urlArray addObject:url3];
    [self.urlArray addObject:url4];
    [self.urlArray addObject:url5];
    //一共有五张图片
    self.imageNum = 5;
    //初始化cache的文件路径以及fileManager
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    self.cachePath = [paths objectAtIndex:0];
    self.fileManager = [NSFileManager defaultManager];
    //初始化图片本地存储的文件路径
    for(int i = 0;i < self.imageNum;i++){
        NSString* filePath = [self.cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d",i+30]];
        [self.localImgPath addObject:filePath];
    }
}

//设置UICollectionView的Cell
-(UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ImageCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imagecell" forIndexPath:indexPath];
    [cell setController:self];
    [cell setProperty:self.imageArray[indexPath.row]];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

//设置cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.bounds.size.width-20, 250);
}

//设置cell的间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 30;
}

//加载按键按下时
- (void)loadBtnClick{
    //判断cache中是否有缓存图片
    NSString * filePath = [self.cachePath stringByAppendingPathComponent:@"30"];
    //若文件存在
    if([self.fileManager fileExistsAtPath:filePath]){
        //直接从cache中读取图片
        for(int i = 0; i < self.imageNum; i++) {
            NSData* imageData = [NSData dataWithContentsOfFile:self.localImgPath[i]];
            UIImage* image = [[UIImage alloc] initWithData:imageData];
            [self.imageArray addObject:image];
        }
        [self.collectionView reloadData];
    }
    //若文件不存在，需要调用子线程下载图片
    else{
        [self load];
    }
}

//清空按钮按下时
- (void)clearBtnClick{
    //情况UICollection中的图片
    [self.imageArray removeAllObjects];
    [self.collectionView reloadData];
}

//删除缓存按钮下时
- (void)deleteBtnClick{
    for(int i = 0;i < self.imageNum;i++){
        if([self.fileManager fileExistsAtPath:self.localImgPath[i]]){
            [self.fileManager removeItemAtPath:self.localImgPath[i] error:nil];
        }
    }
}


//下载图片
-(void)load{
    //[self.localImgPath removeAllObjects];
    //图片加载完成前显示loading图标
    for(int i = 0; i < self.imageNum; i++) {
        [self.imageArray addObject:self.loadingImage];
    }
    [self.collectionView reloadData];
    //创建自定义线程队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //创建五个子线程分别下载图片
    for(int i = 0; i < self.imageNum; i++) {
        NSBlockOperation* op = [NSBlockOperation blockOperationWithBlock:^{
            NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlArray[i]]];
            UIImage* img = [UIImage imageWithData:data];
            //将下载得到的图片写入到cache
            if([UIImagePNGRepresentation(img) writeToFile:self.localImgPath[i] atomically:YES]) {
                //再将图片放入imageArray中以便显示
                [self.imageArray replaceObjectAtIndex:i withObject:[UIImage imageWithContentsOfFile:self.localImgPath[i]]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    //主线程执行
                    [self.collectionView reloadData];
                });
            }
        }];
        // 将操作加入队列
        [queue addOperation:op];
    }
}

-(void)editEnding{
    [self.view endEditing:YES];
}




@end
