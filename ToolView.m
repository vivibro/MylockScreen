//
//  ToolView.m
//  MylockScreen
//
//  Created by 沈威 on 2017/7/15.
//  Copyright © 2017年 沈威. All rights reserved.
//
#define Padding 5
#define Width (self.frame.size.width - 4*Padding)/5
#import "ToolView.h"
@interface ToolView()
@property(nonatomic,strong)UIButton *penBtn;
@property(nonatomic,strong)UIButton *eraserBten;
@property(nonatomic,strong)UIButton *colorBtn;
@property(nonatomic,strong)UIButton *undoBtn;
@property(nonatomic,strong)UIButton *clearBtn;
@property(nonatomic,strong)UIButton *saveBtn;
@property(nonatomic,strong)UILabel  *lbLineWidth;
@property(nonatomic,strong)UISlider *sliderLine;
@end
@implementation ToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.penBtn];
        [self addSubview:self.eraserBten];
        [self addSubview:self.colorBtn];
        [self addSubview:self.undoBtn];
        [self addSubview:self.clearBtn];
        [self addSubview:self.saveBtn];
        [self addSubview:self.sliderLine];
        [self addSubview:self.lbLineWidth];
        
    }
    return self;
}
-(void)penAction{
    [self.penBtn setBackgroundColor:[UIColor colorWithRed:210.0/255.0 green:105.0/255.0 blue:30.0/255.0 alpha:1]];
    [self.eraserBten setBackgroundColor:[UIColor orangeColor]];
    if (self.penBlock) {
        self.penBlock();
    }
}
-(void)eraserAction{
    [self.eraserBten setBackgroundColor:[UIColor colorWithRed:210.0/255 green:105.0/255 blue:30.0/255 alpha:1]];
    [self.penBtn setBackgroundColor:[UIColor orangeColor]];
    if (self.eraserBlock) {
        self.eraserBlock();
    }
}
-(void)colorAction{
    if (self.colorBlock) {
        self.colorBlock();
    }
}
-(void)undoAction{
    if (self.undoBlock) {
        self.undoBlock();
    }
}
-(void)clearAction{
    if (self.clearBlock) {
        self.clearBlock();
    }
}
-(void)saveAction{
    if (self.saveBlock) {
        self.saveBlock();
    }
}
-(void)sliderAction:(UISlider*)slider{
    if (self.sliderBlock) {
        CGFloat width=slider.value *10;
        if (width<1) {
            width=1;
        }
        self.lbLineWidth.text=[NSString stringWithFormat:@"%.0f",width];
        self.sliderBlock(width);
    }
}
-(UIButton*)penBtn{
    if (!_penBtn) {
        _penBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _penBtn.frame = CGRectMake(0, 0, Width, 40);
        [_penBtn setTitle:@"画笔" forState:UIControlStateNormal];
        [_penBtn setTintColor:[UIColor whiteColor]];
        [_penBtn setBackgroundColor:[UIColor colorWithRed:210.0/255.0 green:105.0/255.0 blue:30.0/255.0 alpha:1]];
        [_penBtn addTarget:self action:@selector(penAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _penBtn;
}
-(UIButton*)eraserBten{
    if (!_eraserBten) {
        _eraserBten=[UIButton buttonWithType:UIButtonTypeCustom];
        _eraserBten.frame = CGRectMake(CGRectGetMaxX(self.penBtn.frame)+Padding, 0, Width, 40);
        [_eraserBten setTitle:@"橡皮" forState:UIControlStateNormal];
        [_eraserBten setTintColor:[UIColor whiteColor]];
        [_eraserBten setBackgroundColor:[UIColor orangeColor]];
        [_eraserBten addTarget:self action:@selector(eraserAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eraserBten;
}
-(UIButton*)colorBtn{
    if (!_colorBtn) {
        _colorBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _colorBtn.frame = CGRectMake(CGRectGetMaxX(self.eraserBten.frame)+Padding, 0, Width, 40);
        [_colorBtn setTitle:@"颜色" forState:UIControlStateNormal];
        [_colorBtn setTintColor:[UIColor whiteColor]];
        [_colorBtn setBackgroundColor:[UIColor orangeColor]];
        [_colorBtn addTarget:self action:@selector(colorAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _colorBtn;
}

-(UIButton*)undoBtn{
    if (!_undoBtn) {
        _undoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _undoBtn.frame = CGRectMake(CGRectGetMaxX(self.colorBtn.frame)+Padding, 0, Width, 40);
        [_undoBtn setTitle:@"回退" forState:UIControlStateNormal];
        [_undoBtn setTintColor:[UIColor whiteColor]];
        [_undoBtn setBackgroundColor:[UIColor orangeColor]];
        [_undoBtn addTarget:self action:@selector(undoAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _undoBtn;
}
-(UIButton*)clearBtn{
    if (!_clearBtn) {
        _clearBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _clearBtn.frame = CGRectMake(CGRectGetMaxX(self.undoBtn.frame)+Padding, 0, Width, 40);
        [_clearBtn setTitle:@"清屏" forState:UIControlStateNormal];
        [_clearBtn setTintColor:[UIColor whiteColor]];
        [_clearBtn setBackgroundColor:[UIColor orangeColor]];
        [_clearBtn addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
}
-(UIButton*)saveBtn{
    if (!_saveBtn) {
        _saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.frame = CGRectMake(CGRectGetMaxX(self.undoBtn.frame)+Padding, 45, Width, 40);
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTintColor:[UIColor whiteColor]];
        [_saveBtn setBackgroundColor:[UIColor orangeColor]];
        [_saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}
-(UISlider*)sliderLine{
    if (!_sliderLine) {
        _sliderLine = [[UISlider alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-40, CGRectGetWidth(self.frame)/3, 30)];
        [_sliderLine addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        _sliderLine.value=0.2;
    }
    return _sliderLine;
}
-(UILabel*)lbLineWidth{
    if (!_lbLineWidth) {
        _lbLineWidth = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sliderLine.frame) + 20, CGRectGetMinY(self.sliderLine.frame), CGRectGetWidth(self.frame)/3-30, CGRectGetHeight(self.sliderLine.frame))];
        _lbLineWidth.text=@"2";
        _lbLineWidth.textColor=[UIColor redColor];
        
    }
    return _lbLineWidth;
}
@end
