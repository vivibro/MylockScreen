//
//  LineModel.h
//  MylockScreen
//
//  Created by 沈威 on 2017/7/15.
//  Copyright © 2017年 沈威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LineModel : NSObject
@property(nonatomic,assign)CGMutablePathRef path;
@property(nonatomic,strong)UIColor *color;
@property CGFloat lineWidth;
@end
