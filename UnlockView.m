//
//  UnlockView.m
//  MylockScreen
//
//  Created by 沈威 on 2017/7/10.
//  Copyright © 2017年 沈威. All rights reserved.
//

#import "UnlockView.h"
#import "Node.h"
@interface UnlockView()
@property(nonatomic,assign)CGMutablePathRef path;//路径
@property(nonatomic,strong)NSMutableArray *nodes;//表示所有的节点
@property(nonatomic,strong)NSMutableArray *throughNode;//表示穿过的所有点
@property(nonatomic,strong)NSMutableString *secret;//输入的密码
@property BOOL isValidateGesture;//是否有效手势 默认为NO
@end
@implementation UnlockView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.nodes=[NSMutableArray array];
        self.throughNode=[NSMutableArray array];
        self.secret=[[NSMutableString alloc]init];
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bj"]];
        [self initNode];
    }
    return self;
}
-(Node*)ptIsInNodes:(CGPoint)pt{
    Node *isIn = nil;
    for (Node* item in self.nodes) {
        if (CGRectContainsPoint(item.frame, pt)) {
            isIn=item;
            break;
        }
    }
    return isIn;
}

//画9个节点
-(void)initNode{
    CGFloat x = self.frame.size.width/4;
    CGFloat start_y=(self.frame.size.height-self.frame.size.width)/2;
    CGFloat y=x;
    for (int i=0; i<9; i++) {
        Node* node=[[Node alloc]init];
        node.userInteractionEnabled=NO;
        node.center=CGPointMake((i%3+1)*x, start_y+(i/3+1)*y);
        node.bounds=CGRectMake(0, 0, 50, 50);
        node.image=[UIImage imageNamed:@"node_nromal"];
//        node.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"node_nromal"]];
        node.number=[NSString stringWithFormat:@"%d",i+1];
        [self.nodes addObject:node];
        [self addSubview:node];
    }
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextAddPath(context, self.path);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 4);
    CGContextDrawPath(context, kCGPathStroke);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch* touch=touches.anyObject;
    CGPoint pt=[touch locationInView:touch.view];
    Node *itemNode=[self ptIsInNodes:pt];
    if (itemNode) {
        _isValidateGesture=YES;
        self.path=CGPathCreateMutable();
        CGPathMoveToPoint(self.path, NULL, itemNode.center.x, itemNode.center.y);
        [self.throughNode addObject:itemNode];
        [self.secret appendFormat:@"%@", itemNode.number];
        itemNode.image=[UIImage imageNamed:@"node_highlight"];
        
    }
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_isValidateGesture) {
        return;
    }
    UITouch* touch=touches.anyObject;
    CGPoint pt=[touch locationInView:touch.view];
    Node *itemNode=[self ptIsInNodes:pt];
    
    if (itemNode) {
        if (![self.throughNode containsObject:itemNode]) {
            CGPathAddLineToPoint(self.path, nil, itemNode.center.x, itemNode.center.y);
            [self setNeedsDisplay];
            itemNode.image=[UIImage imageNamed:@"node_highlight"];
            [self.throughNode addObject:itemNode];
            [self.secret appendFormat:@"%@",itemNode.number];
        }  
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_isValidateGesture) {
        return;
    }
    [self.throughNode removeAllObjects];
    CGPathRelease(self.path);
    self.path=nil;
    for (Node* item in self.nodes) {
        item.image=[UIImage imageNamed:@"node_nromal"];
    }
    [self setNeedsDisplay];
    [self cheak];
    _isValidateGesture=NO;
    [self.secret setString:@""];
}
-(void)cheak{
    if ([self.secret isEqualToString:@"14789"]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ENDTERTHEDRAW" object:nil];
        
    }
}
@end
