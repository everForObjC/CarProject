//
//  BaseViewController.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/8.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "BaseViewController.h"
#import "SmallView.h"

#import "PhotoesViewController.h"
#import "ShareViewController.h"
#import "QQLoginViewController.h"

#import "MySetViewController.h"
#import "NewViewController.h"

@interface BaseViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIImagePickerController * imagePickerController;
@property (nonatomic,strong) UIImageView *headPortraitImageView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNumberView:) name:@"pushNewView" object:nil];
    
}

- (void)pushNumberView:(NSNotification *)noti{
    
    NSInteger number = [noti.userInfo[@"number"] integerValue];
    
    if (number == 0) {
        
        UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从本地选取照片" otherButtonTitles:@"使用相机拍照", nil];
        [sheet showInView:self.view];
        
    }else if (number == 1){
    
        ShareViewController * vc = [[ShareViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (number == 2){
        QQLoginViewController * vc = [[QQLoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

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
