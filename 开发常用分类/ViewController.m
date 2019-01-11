//
//  ViewController.m
//  开发常用分类
//
//  Created by Mac2 on 2018/8/15.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Supplement.h"
#import "UIColor+Supplement.h"
#import "UIImageView+Supplement.h"
#import "NSString+Supplement.h"
#import "NSMutableAttributedString+Supplement.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.imageView = [UIImageView imageViewWithImage:[UIImage imageNamed:@"02"] frame:CGRectMake(100, 100, 100, 100)];
    [self.imageView setFilletedCornerWithRadius:50];
    
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    NSLog(@"%@",[[UIColor redColor] HEXString]);
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addBaseImage)];
    [self.imageView addGestureRecognizer:tap];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 5;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"孩子安徽覅恢复期货就放弃和恢复期hi会务费附加费航空文化服务卡能否尽快为您附近问你问客服那我就服你文件发你文件您付款文件南方网恢复期货就放弃和恢复期hi会务费附加费航空文化服务卡能否尽快为您附近问你问客服那我就服你文件发你文件您付款文件南方网" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"ff0000"],NSFontAttributeName: [UIFont systemFontOfSize:15], NSParagraphStyleAttributeName: paragraph}];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 5)];
    CATextLayer *layer = [[CATextLayer alloc] init];
    layer.frame = CGRectMake(0, 500, screen_width, 10);
    layer.string = attributedString;
    layer.bounds = [attributedString boundingRectWithSize:CGSizeMake(screen_width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    layer.fontSize = 15;
    layer.wrapped = YES;
    layer.truncationMode = kCATruncationEnd;
    layer.contentsScale = [[UIScreen mainScreen] scale];
    [self.view.layer addSublayer:layer];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 600, screen_width, 100)];
    self.label.numberOfLines = 0;
    self.label.backgroundColor = [[UIColor colorWithHexString:@"ff0000"] translucentColor];
    NSDictionary *dic = @{
                          @"marker":@{@"font":[UIFont systemFontOfSize:20], @"color": [UIColor greenColor], @"text":@"hello"},
                          @"body":@{@"font":[UIFont systemFontOfSize:12], @"color":[UIColor redColor]}
                          };
    self.label.attributedText = [NSMutableAttributedString attributeWithDic:dic string:@"hello和覅无回复无回复我凤凰网结尾鸡尾酒分开交罚款京津冀平均欧赔键盘就离开普及破解欧派奇偶奇偶奇偶军坡节噢迫击炮建瓯盘奇偶平均欧赔奖品奖品奖品奖品家平均欧赔键盘"];
    [self.view addSubview:self.label];
    
    NSString *string = @"helloworld";
    NSRange range = [string rangeOfString:@"world"];
    NSLog(@"%@",[string substringWithRange:range]);
}

- (void)addBaseImage {
    [self showAlertView];
}

- (void)showAlertView {
    // 创建UIImagePickerController实例
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    // 设置代理
    imagePickerController.delegate = self;
    // 是否允许编辑（默认为NO）
    //    imagePickerController.allowsEditing = YES;
    // 创建一个警告控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 设置警告响应事件
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 设置照片来源为相机
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置进入相机时使用前置或后置摄像头
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 展示选取照片控制器
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];
    UIAlertAction *photosAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 添加警告按钮
        [alert addAction:cameraAction];
    }
    [alert addAction:photosAction];
    [alert addAction:cancelAction];
    // 展示警告控制器
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 选取完图片后跳转回原控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    /* 此处参数 info 是一个字典，下面是字典中的键值 （从相机获取的图片和相册获取的图片时，两者的info值不尽相同）
     * UIImagePickerControllerMediaType; // 媒体类型
     * UIImagePickerControllerOriginalImage; // 原始图片
     * UIImagePickerControllerEditedImage; // 裁剪后图片
     * UIImagePickerControllerCropRect; // 图片裁剪区域（CGRect）
     * UIImagePickerControllerMediaURL; // 媒体的URL
     * UIImagePickerControllerReferenceURL // 原件的URL
     * UIImagePickerControllerMediaMetadata // 当数据来源是相机时，此值才有效
     */
    // 从info中将图片取出，并加载到imageView当中
    if ([picker allowsEditing]) {
        self.imageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
    }else {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *data = [image compressImageWithMaxLength:50 * 1024];
        image = [UIImage imageWithData:data];
        self.imageView.image = image;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
