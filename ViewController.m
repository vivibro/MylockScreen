//
//  ViewController.m
//  MylockScreen
//
//  Created by 沈威 on 2017/7/10.
//  Copyright © 2017年 沈威. All rights reserved.
//

#import "ViewController.h"
#import "UnlockView.h"
#import "FunctionViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UnlockView *unlock=[[UnlockView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:unlock];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(action) name:@"ENDTERTHEDRAW" object:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)action{
    FunctionViewController *f1=[[FunctionViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:f1];
    [nav setNavigationBarHidden:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
