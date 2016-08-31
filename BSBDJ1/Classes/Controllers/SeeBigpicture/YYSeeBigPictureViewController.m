//
//  YYSeeBigPictureViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/25.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYSeeBigPictureViewController.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import <Photos/Photos.h>

@interface YYSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic)  UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end
/** 相簿名称 */
static NSString * const YYAssetCollectionTitle = @"悦思的百思不得姐";


@implementation YYSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupImageView];
}

-(void)setupImageView{
    // request largeImage
    if(!_imageView){
        UIImageView *imageView = [[UIImageView alloc]init];
        self.imageView = imageView;
    }
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            [SVProgressHUD showWithStatus:@"下载失败"];
            return ;
        }
        self.saveButton.enabled = YES;
    }];
    [self.scrollView addSubview:self.imageView];
    
    _imageView.x = 0;
    _imageView.width = YYScreenW;
    _imageView.height = self.model.height * _imageView.width / self.model.width;

    
    if (_imageView.height >= YYScreeH) {
        _imageView.y = 0;
        _scrollView.contentSize = CGSizeMake(0, _imageView.height);
    }else{
        _imageView.centerY = self.view.centerY;
    }
    // Zoom
    CGFloat maxScale = self.model.height / _imageView.height;
    if (maxScale > 1.0) {
        _scrollView.maximumZoomScale = maxScale;
    }
}

- (IBAction)backButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonClick:(id)sender {
    // Auth
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];

    switch (status) {
        case PHAuthorizationStatusNotDetermined: {
            //用户还未做出选择 让用户做选择 拒绝显示一个信息 同意就访问照片（保存）
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusDenied) {
                    [SVProgressHUD showErrorWithStatus:@"用户拒绝"];
                }else if(status == PHAuthorizationStatusAuthorized){
                    [self saveImage];
                }
            }];
            break;
        }
        case PHAuthorizationStatusRestricted: {
            [SVProgressHUD showErrorWithStatus:@"因为操作系统原因，无法保存图片!"];
            break;
        }
        case PHAuthorizationStatusDenied: {
             [SVProgressHUD showErrorWithStatus:@"打开Photos的隐私访问开关【设置-隐私-照片-百思项目】"];
            break;
        }
        case PHAuthorizationStatusAuthorized: {
            [self saveImage];
            break;
        }
    }
    
    
}
-(void)saveImage{
    
    // 1.保存图片到【相机胶卷】

    NSError *error = nil;
    __block NSString *assetID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
       assetID = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:(&error)];
   // 2.添加图片到相簿
[[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
     // 利用request对象添加图片到相簿中
    PHAssetCollectionChangeRequest *request = nil;
    PHAssetCollection *createdCollection = nil;
    // 先尝试获取之前创建过的相簿

    // 拿到所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿 如果有的话就保存起来
    for (PHAssetCollection *collection in collections) {
        if([collection.localizedTitle isEqualToString:YYAssetCollectionTitle]){
            createdCollection = collection;
            break;
        }
    }
    // 曾经创建过相簿
    if(createdCollection){
        request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
    }else{
        //创建新相簿
        request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:YYAssetCollectionTitle];
    }
    // 添加刚才保存成功的图片到【自定义相簿】
    [request addAssets:[PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil]];
    
} error:&error];
    if(error){
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
        
}
#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
