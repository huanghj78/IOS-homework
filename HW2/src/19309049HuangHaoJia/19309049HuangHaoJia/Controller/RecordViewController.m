//
//  RecordViewController.m
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/8.
//

#import <Foundation/Foundation.h>
#import "RecordViewController.h"

@interface RecordViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(strong,nonatomic) UICollectionView * photos;//组织添加的图片
@property(strong,nonatomic) NSMutableArray * photoData;//暂存将要发布的图片
@property(strong,nonatomic) UITextField * timeTextField;//时间输入框
@property(strong,nonatomic) UITextField * placeTextField;//地点输入框
@property(strong,nonatomic) UITextField * clothesTextField;//穿搭输入了
@property(strong,nonatomic) UITextView * feelTextView;//心得输入框
@property(strong,nonatomic) RecordsController * rc;//记录存储控制器
@property(strong, nonatomic) UIViewController * su;//父视图控制器
@property(strong, nonatomic) UIImage * defaultImage;//默认图片，即为加号图片
@property(strong, nonatomic) UIImagePickerController* imagePickerController;//图片选择器
@property(strong, nonatomic) UIImageView* imagePickerControllerView;//选择图片的视图
@property(strong, nonatomic) UIAlertController* alert;//弹窗
@property(strong, nonatomic) UIAlertController* commitAlert;//提交弹窗
@end

@implementation RecordViewController
-(id)initWithSuper:(UIViewController*)su{
    self = [super init];
    self.su = su;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.su.title = @"添加记录";
    self.title = @"Record";
    self.photoData = [[NSMutableArray alloc]init];
    self.rc = [[RecordsController alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建提示文本
    UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 50, 50)];
    UILabel * placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 170, 50, 50)];
    UILabel * clothesLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 240, 50, 50)];
    UILabel * feelLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 310, 50, 50)];
    UILabel * photoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.view.bounds.size.height-400, 50, 50)];
   // timeLabel.layer.borderWidth = 1;
    timeLabel.text = @"时间";
   // placeLabel.layer.borderWidth = 1;
    placeLabel.text = @"地点";
   // clothesLabel.layer.borderWidth = 1;
    clothesLabel.text = @"搭配";
   // feelLabel.layer.borderWidth = 1;
    feelLabel.text = @"心得";
    //timeLabel.textColor = [UIColor redColor];
    photoLabel.text = @"配图";
    [self.view addSubview:timeLabel];
    [self.view addSubview:placeLabel];
    [self.view addSubview:clothesLabel];
    [self.view addSubview:feelLabel];
    [self.view addSubview:photoLabel];
    
    //创建输入框
    self.timeTextField = [[UITextField alloc]initWithFrame:CGRectMake(70, 110, 300, 40)];
    //timeTextField.layer.borderWidth = 1;
    self.timeTextField.placeholder = @"2021-10-10";
    self.timeTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.placeTextField = [[UITextField alloc]initWithFrame:CGRectMake(70, 180, 300, 40)];
    //placeTextField.layer.borderWidth = 1;
    self.placeTextField.placeholder = @"SYSU";
    self.placeTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.clothesTextField = [[UITextField alloc]initWithFrame:CGRectMake(70, 250, 300, 40)];
    //clothesTextField.layer.borderWidth = 1;
    self.clothesTextField.placeholder = @"白色T恤+黑色短裤";
    self.clothesTextField.borderStyle = UITextBorderStyleRoundedRect;

    self.feelTextView =[[UITextView alloc]initWithFrame:CGRectMake(70, 320, 300, 120)];
    self.feelTextView.layer.borderColor = [[UIColor grayColor]CGColor];
    self.feelTextView.layer.borderWidth = 1;
    self.feelTextView.layer.cornerRadius = 5.0;
    
    self.timeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.placeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.clothesTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.feelTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.timeTextField];
    [self.view addSubview:self.placeTextField];
    [self.view addSubview:self.clothesTextField];
    [self.view addSubview:self.feelTextView];
    
    //设置默认图片
    self.defaultImage = [UIImage imageNamed:@"add.jpeg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    //初始化图片选择控制器
    self.imagePickerController=[[UIImagePickerController alloc]init];
    self.imagePickerController.delegate=self;
    self.imagePickerControllerView=[[UIImageView alloc]initWithFrame:CGRectMake(40, 100, 200, 200)];
    self.imagePickerControllerView.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imagePickerControllerView];
    
    //初始化提交按钮
    UIButton * commitButton = [[UIButton alloc]initWithFrame:CGRectMake(2*self.view.bounds.size.width / 5, self.view.bounds.size.height-120, self.view.bounds.size.width/5, 30)];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitle:@"提交" forState:UIControlStateHighlighted];
    [commitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [commitButton.layer setBorderWidth:1];
    [commitButton.layer setCornerRadius:10.0];
    [commitButton addTarget:self action:@selector(btnCliked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    
    //[self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Record";
    //[self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    [self.su setTitle:@"穿搭记录"];
    
    //初始化CollectionView
    if(self.photos != nil) {
        [self.photos removeFromSuperview];
    }
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(345, 100);
    self.photos = [[UICollectionView alloc]initWithFrame:CGRectMake(20, self.view.bounds.size.height-350, self.view.bounds.size.width-40, 230) collectionViewLayout:layout];
    self.photos.backgroundColor = [UIColor whiteColor];
    [self.photos setDataSource:self];
    [self.photos setDelegate:self];
    [self.photos registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"checkout"];
    [self.view addSubview:self.photos];
    //为Collection添加点击识别手势
    UIGestureRecognizer* touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editEnding)];
    [self.photos addGestureRecognizer:touch];
    self.photos.userInteractionEnabled = true;
    
}

//检查输入框是否有文字输入
-(BOOL)check{
    if([self.timeTextField.text isEqualToString:@""] || [self.placeTextField.text isEqualToString:@""] || [self.clothesTextField.text isEqualToString:@""] || [self.feelTextView.text isEqualToString:@""]){
        return false;
    }
    return  true;
}

//提交按钮点击的响应函数
-(void)btnCliked{
    //若有文本框无输入，则不作任何响应
    if(![self check]){
        return;
    }
    //读取文本输入框的内容创建一个新的record并通过RecordController添加到RecordStroage中
    Records * newRecord = [[Records alloc]init:self.timeTextField.text at:self.placeTextField.text dressed:self.clothesTextField.text feels:self.feelTextView.text with:self.photoData];
    [self.rc add:newRecord];
    //清空文本输入框
    self.timeTextField.text = @"";
    self.placeTextField.text = @"";
    self.clothesTextField.text = @"";
    self.feelTextView.text = @"";
    //弹窗提醒发布成功
    self.commitAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"发布成功" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:self.commitAlert animated:YES completion:nil];
    [self performSelector:@selector(hideAlert) withObject:self.commitAlert afterDelay:0.5];
    //重置图片缓存
    self.photoData = [[NSMutableArray alloc]init];
}

//隐藏弹窗并跳转至发现页面
-(void)hideAlert{
    [self.commitAlert dismissViewControllerAnimated:YES completion:nil];
    self.tabBarController.selectedViewController = self.tabBarController.viewControllers[0];
}


-(void)editEnding{
    [self.view endEditing:YES];
}

//- (void)dismissAlertView:(NSTimer*)timer {
//    [self.alert dismissViewControllerAnimated:YES completion:nil];
//    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
//}

//选择完图片之后，隐藏图片选择框，并把选中的图片加入图片缓存数组中
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self addImage:image];
}

//图片的显示
-(UICollectionViewCell*)collectionView:(nonnull UICollectionView*)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    //cell的回收利用
    PhotoCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"checkout" forIndexPath:indexPath];
    NSInteger count = self.photoData.count;
    NSInteger from = row * 3;
        
    UIImage* image1 = nil;
    UIImage* image2 = nil;
    UIImage* image3 = nil;
    BOOL defaultUsed = NO;
    NSInteger defaultIndex = 0;
        
    if(count <= from) {
        defaultUsed = YES;
        defaultIndex = 1;
        image1 = self.defaultImage;
    } else {
        image1 = self.photoData[from];
    }
    from ++;
    if(count <= from) {
        if(defaultUsed == NO) {
            defaultUsed = YES;
            defaultIndex = 2;
            image2 = self.defaultImage;
        }
    } else {
        image2 = self.photoData[from];
    }
    from++;
    if(count <= from) {
        if(defaultUsed == NO) {
            defaultUsed = YES;
            defaultIndex = 3;
            image3 = self.defaultImage;
        }
    } else {
        image3 = self.photoData[from];
    }
    [cell setController:self];
    [cell setProperty:image1 with:image2 with:image3 canClick:defaultIndex];
    return cell;
}

//代理函数，设置Collection中每个section有多少个cell
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger line;
    if(self.photoData.count == 0) {
        line = 1;
    } else {
        if(self.photoData.count % 3 == 0) {
            line = (self.photoData.count) / 3 + 1;
        } else {
            line = self.photoData.count / 3 + 1;
        }
    }
    return line;
}

- (IBAction)openPickerPickController {
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}


- (void) addImage: (UIImage*) image {
    [self.photoData addObject:image];
    [self viewWillAppear: YES];
}

@end
