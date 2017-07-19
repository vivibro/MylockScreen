//
//  ToolView.h
//  MylockScreen
//
//  Created by 沈威 on 2017/7/15.
//  Copyright © 2017年 沈威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolView : UIView
//回调
@property(nonatomic,copy) void(^penBlock)();
@property(nonatomic,copy) void(^eraserBlock)();
@property(nonatomic,copy) void(^colorBlock)();
@property(nonatomic,copy) void(^undoBlock)();
@property(nonatomic,copy) void(^clearBlock)();
@property(nonatomic,copy) void(^saveBlock)();
@property(nonatomic,copy) void(^sliderBlock)(CGFloat width);
@end
