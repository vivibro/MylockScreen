//
//  ColorView.h
//  MylockScreen
//
//  Created by 沈威 on 2017/7/15.
//  Copyright © 2017年 沈威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorView : UIView
-(void)showAnimation;
@property(nonatomic,copy) void(^selectColorBlock)(UIColor *color);
@end
