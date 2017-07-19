//
//  FunctionViewController.m
//  MylockScreen
//
//  Created by 沈威 on 2017/7/13.
//  Copyright © 2017年 沈威. All rights reserved.
//

#import "FunctionViewController.h"
#import "CanvasViewController.h"
@interface FunctionViewController ()

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(self.view.center.x-40, self.view.frame.size.height-50, 80, 50);
    [backBtn setImage:[UIImage imageNamed:@"chahao"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //绘图板按钮
    UIButton *canvasbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canvasbtn.frame=CGRectMake(self.view.center.x-50, self.view.center.y, 100, 50);
    [canvasbtn setTitle:@"画图版" forState:UIControlStateNormal];
    [canvasbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [canvasbtn addTarget:self action:@selector(clickCanvs:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:canvasbtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickBack:(UIButton*)bt{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)clickCanvs:(UIButton*)bt{
    CanvasViewController *vc=[[CanvasViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
