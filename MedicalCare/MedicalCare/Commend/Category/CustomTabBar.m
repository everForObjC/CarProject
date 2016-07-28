//
//  CustomTabBar.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/8.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "CustomTabBar.h"
#import "MyCenterViewController.h"
#import "HealthyViewController.h"
#import "LocationHospitalViewController.h"
#import "FirstAidViewController.h"
#import "SearchDrugViewController.h"
#import "SmallView.h"
#import "MySetUp.h"
#import "MySetViewController.h"

#import "NewViewController.h"

#import "PhotoesViewController.h"
#import "ShareViewController.h"
#import "QQLoginViewController.h"

#import <TencentOpenAPI/TencentOAuth.h>

#define BTN_FRAME 100
#define SMALLVIEW_WIDTH 200
#define SMALLVIEW_HEIDTH 150

@interface CustomTabBar ()<MySetUpDelegate,SmallViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,TencentSessionDelegate>

{
    TencentOAuth *tencentOAuth;
    BOOL isOpen;
    BOOL isFirst;
}



@property (nonatomic,strong) UIImagePickerController * imagePickerController;
@property (nonatomic,strong) UIImageView *headPortraitImageView;

@property (nonatomic,strong) UITabBarController * tabBar;

@property (nonatomic,strong) NSArray * imageArr;
@property (nonatomic,strong) NSArray * titleArr;
@property (nonatomic,strong) NSArray * selectImage;
@property (nonatomic,strong) NSArray * nameArr;

@property (nonatomic,strong) SmallView * sView;

@property (nonatomic,strong) MySetUp * table;

@end

@implementation CustomTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar = [[UITabBarController alloc]init];
    isOpen = NO;
    isFirst = NO;
    _titleArr = @[@"Healthy",@"SearchDrug",@"LocationHospital",@"MyCenter"];
    _imageArr = @[@"account_normal",@"fish_normal",@"home_normal",@"mycity_normal"];
    _selectImage = @[@"account_highlight",@"fish_highlight",@"home_highlight",@"mycity_highlight"];
    _nameArr = @[@"健康咨询",@"药品信息",@"药店查询",@"病状信息"];
    
    UIImageView * imageV = [[UIImageView alloc] initWithFrame:self.view.bounds] ;
    imageV.image = [UIImage imageNamed:@"guide_3_736"] ;
    
    _table = [[MySetUp alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

    _table.delegate = self;
    imageV.userInteractionEnabled = YES;
    [imageV addSubview:_table];
    
    [self.view addSubview:imageV] ;
    [self creatTabBarViews];
    

    [self.view addSubview:self.tabBar.view];

}
- (void)pushMySetUpView:(NSInteger)viewID{
    
    NewViewController * vc = [[NewViewController alloc]init];
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:vc];
    //firstObject

    [[self.tabBar.viewControllers firstObject] presentViewController:navi animated:YES completion:nil];
    
    
}

- (UIViewController *)viewContrllerWithTitle:(NSString *)title andImage:(UIImage *)image andSelectImage:(UIImage *)selectImage andName:(NSString *)name{

    NSString * clssName = [NSString stringWithFormat:@"%@ViewController",title];
    Class myClass = NSClassFromString(clssName);
    UIViewController * viewController = [[myClass alloc]init];
    viewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:name image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UIBarButtonItem * barBut = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"night_top_navigation_square"] style:UIBarButtonItemStyleDone target:self action:@selector(pressRightBtn)];

    
    viewController.navigationItem.leftBarButtonItem = barBut;
    viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor yellowColor]} forState:UIControlStateSelected] ;
    
    viewController.title = name;
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:viewController];

    
    return navi;
}

- (void)pressRightBtn{
    if (isFirst == NO) {
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBar.view.frame = CGRectMake(300, 0, self.view.frame.size.width, self.view.frame.size.height) ;
        }] ;
    }else{
    
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBar.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) ;
        }] ;
    }
   
    isFirst = !isFirst;
}

- (void)creatTabBarViews{
    
    self.tabBar.viewControllers = [NSArray arrayWithObjects:[self viewContrllerWithTitle:_titleArr[0] andImage:[UIImage imageNamed:_imageArr[0]] andSelectImage:[UIImage imageNamed:_selectImage[0]] andName:_nameArr[0]], [self viewContrllerWithTitle:_titleArr[1] andImage:[UIImage imageNamed:_imageArr[1]] andSelectImage:[UIImage imageNamed:_selectImage[1]] andName:_nameArr[1]], [self viewContrllerWithTitle:nil andImage:nil andSelectImage:nil andName:nil] ,[self viewContrllerWithTitle:_titleArr[2] andImage:[UIImage imageNamed:_imageArr[2]] andSelectImage:[UIImage imageNamed:_selectImage[2]] andName:_nameArr[2]] ,[self viewContrllerWithTitle:_titleArr[3] andImage:[UIImage imageNamed:_imageArr[3]] andSelectImage:[UIImage imageNamed:_selectImage[3]] andName:_nameArr[3]], nil];
        [self creatBtn];
    
   
}

- (void)creatBtn{

    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, BTN_FRAME, BTN_FRAME)];
    btn.center = CGPointMake(SCREEN_WIDTH / 2, TABBAR_HEIGHT /2 - 20);
    [btn setImage:[UIImage imageNamed:@"chooser-button-input"] forState:UIControlStateNormal];
    btn.layer.cornerRadius = BTN_FRAME/2;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = [UIColor blackColor];
    [self.tabBar.tabBar addSubview:btn];
    
}

- (void)pressBtn:(UIButton *)btn{
    if (isOpen == NO) {

        [self creatBtns];
        CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.8;
        NSValue * value = [NSValue valueWithCATransform3D:CATransform3DRotate(btn.layer.transform, M_PI_4*3, 0, 0, 1)];
        animation.values = @[value];
        animation.removedOnCompletion = NO;
        
        animation.fillMode = kCAFillModeForwards;
        
        [btn.layer addAnimation:animation forKey:nil];
      
    }else{

        [self.sView removeFromSuperview];
        CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.8;
        NSValue * value = [NSValue valueWithCATransform3D:CATransform3DRotate(btn.layer.transform, -M_PI_4*2, 0, 0, 1)];
        animation.values = @[value];
        animation.removedOnCompletion = NO;
        
        animation.fillMode = kCAFillModeForwards;
        
        [btn.layer addAnimation:animation forKey:nil];

    }
    isOpen = !isOpen;
    
}

- (void)creatBtns{

     self.sView = [[SmallView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49)];
    self.sView.delegate = self;
     [self.view addSubview:self.sView];
    
}

- (void)deledateSmallView{

    [self.sView removeFromSuperview];
    [UIView animateWithDuration:0.2 animations:^{
        self.sView.frame = CGRectMake(0, 0, 0, 0);
    }];
    
}

- (void)pushNumberView:(NSInteger)number{
   isOpen = !isOpen;
    
    if (number == 0) {
        
        UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从本地选取照片" otherButtonTitles:@"使用相机拍照", nil];
        [sheet showInView:self.view];
        
    }else if (number == 1){
        
        ShareViewController * vc = [[ShareViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:navi animated:YES completion:nil];
    }else if (number == 2){

        [self toLogin];
    }

    
}

- (void)toLogin
{
    tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1105260675" andDelegate:self];
    NSArray *permissions = [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
    [tencentOAuth authorize:permissions inSafari:YES];
}

#pragma TencentSessionDelegate
- (void)tencentDidLogin
{
    [tencentOAuth getUserInfo];
}

- (void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"%@",response);
    ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:response.jsonResponse[@"figureurl_qq_2"]]]];
        NSString * name = [NSString stringWithFormat:@"%@",response.jsonResponse[@"nickname"]];
        
//        if (self.myImage) {
//            self.myImage(img,name);
//        }
        _table.iamgeV.image = img;
        _table.nameL.text = name;
    });
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        [self selectPhotoAlbumPhotos];
        
    }else if(buttonIndex == 1){
        
        [self takingPictures];
    }
}

- (void)selectPhotoAlbumPhotos{
    
    _imagePickerController = [[UIImagePickerController alloc]init];
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    _imagePickerController.delegate = self;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSLog(@"User chosed imageView media with info '%@'.", info);
    
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    _headPortraitImageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)takingPictures{
    
    NSArray * mediaType = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePickerController.mediaTypes = @[mediaType[0]];
        _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        _imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        _imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        [self presentViewController:_imagePickerController animated:YES completion:nil];
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
