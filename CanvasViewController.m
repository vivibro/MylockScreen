//
//  CanvasViewController.m
//  MylockScreen
//
//  Created by 沈威 on 2017/7/13.
//  Copyright © 2017年 沈威. All rights reserved.
//

#import "CanvasViewController.h"
#import "CanvasView.h"
#import "ToolView.h"
#import "ColorView.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface CanvasViewController ()
@property(nonatomic,strong) CanvasView *canvasView;
@property(nonatomic,strong) ToolView *toolView;
@property(nonatomic,strong) ColorView *colorView;
@property BOOL bEraserMode;
@property UIColor *lastColor;
@property CGFloat lastLineWidth;
@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
//    返回键
    self.lastColor=[UIColor blackColor];
    self.lastLineWidth=2;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(self.view.center.x-40, self.view.frame.size.height-50, 80, 50);
    [backBtn setImage:[UIImage imageNamed:@"chahao"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    self.lastColor=[UIColor blackColor];
    self.lastLineWidth=2;
    [self.view addSubview:self.canvasView];
    [self.view addSubview:self.toolView];
    [self.view addSubview:self.colorView];
    [self.view addSubview:backBtn];
    [self configToolView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickBack:(UIButton*)bt{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CanvasView*)canvasView{
    if (!_canvasView) {
        _canvasView=[[CanvasView alloc]initWithFrame:CGRectMake(20, 130, self.view.frame.size.width-40, self.view.frame.size.height-130-20)];
    }
    return _canvasView;
}
-(ToolView*)toolView{
    if (!_toolView) {
        _toolView=[[ToolView alloc]initWithFrame:CGRectMake(20, 30, self.view.frame.size.width-40,100)];
    }
    return _toolView;
}
-(ColorView*)colorView{
    if (!_colorView) {
        _colorView=[[ColorView alloc]initWithFrame:self.view.frame];
                    }
    __weak typeof(self) wekaify =self;
    _colorView.selectColorBlock=^(UIColor *color){
        if (!wekaify.bEraserMode) {
            wekaify.canvasView.color=color;
        }
        wekaify.lastColor=color;
    };
    return _colorView;
}

-(void)configToolView{
    __weak typeof(self) weakself = self;
    self.toolView.penBlock=^{
        weakself.bEraserMode=NO;
        weakself.canvasView.color=weakself.lastColor;
        weakself.canvasView.lineWidth=weakself.lastLineWidth;
    };
    self.toolView.eraserBlock=^{
        weakself.bEraserMode=YES;
        weakself.canvasView.color=[UIColor whiteColor];
        weakself.canvasView.lineWidth=50;
    };
    self.toolView.colorBlock=^{
        [weakself.colorView showAnimation];
    };
    self.toolView.undoBlock = ^{
        [weakself.canvasView undo];
    };
    self.toolView.clearBlock = ^{
        [weakself.canvasView clear];
    };
    self.toolView.saveBlock = ^{
        [weakself saveImageToAlbum:[weakself screenView:weakself.canvasView]];
    };
    self.toolView.sliderBlock = ^(CGFloat width) {
        if (!weakself.bEraserMode) {
            weakself.canvasView.lineWidth=width;
        }
        weakself.lastLineWidth=width;
    };
}
-(void)saveImageToAlbum:(UIImage*)image{
    //检查是否有相册权限
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    //没有权限或者未选择权限
    if (status==PHAuthorizationStatusDenied||status==PHAuthorizationStatusRestricted) {
        NSLog(@"没有访问权限");
    }else{
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void * _Nullable)(self));
    }
}
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void*)contextInfo{
    if (error) {
        NSLog(@"保存图标失败");
    }else{
        NSLog(@"保存图标成功");
    }
}
-(UIImage*)screenView:(UIView*)view{
    //设置截图区域
    CGRect rect = view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
