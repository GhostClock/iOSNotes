//
//  ViewController.m
//  CoreAnimation
//
//  Created by GhostClock on 2017/12/13.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()<CALayerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
//    [self Spriteimage];
    
//    [self contentsCenter];
    
    [self customDrawimg];
    
    
}

#pragma mark - 初探layer
- (void)knowLayer {
    UIView *layerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    layerview.backgroundColor = [UIColor whiteColor];
    layerview.center = self.view.center;
    [self.view addSubview:layerview];
    
//    CALayer *blueLayer = [CALayer layer];
//    blueLayer.frame = CGRectMake(50, 50, 100, 100);
//    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
//    [layerview.layer addSublayer:blueLayer];
    
    UIImage *image = [UIImage imageNamed:@"timg"];
    layerview.layer.contents = (__bridge id)image.CGImage;
    
//    layerview.contentMode = UIViewContentModeScaleAspectFill;
    layerview.layer.contentsGravity = kCAGravityCenter;
    //如果contentsGravity设置成kCAGravityResizeAspect是不会产生影响,只有设置成kCAGravityCenter才会有影响
//    layerview.layer.contentsScale = 1;
    layerview.layer.contentsScale = image.scale;
    //手动设置图层的contentsScale，用以在Retina设备上显示正确
    layerview.layer.contentsScale = [UIScreen mainScreen].scale;
    //是否超出边界显示 YES是不显示， NO是显示
    layerview.layer.masksToBounds = YES;
    
}
#pragma mark - 拆分图片显示
- (void)Spriteimage {
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(200, 0, 200, 200)];
    UIView *v3 = [[UIView alloc]initWithFrame:CGRectMake(0, 300, 200, 200)];
    UIView *v4 = [[UIView alloc]initWithFrame:CGRectMake(200, 300, 200, 200)];
    [self.view addSubview:v1];
    [self.view addSubview:v2];
    [self.view addSubview:v3];
    [self.view addSubview:v4];
    
    UIImage *image = [UIImage imageNamed:@"Sprites"];
    [self addSpriteimage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:v1.layer];
    [self addSpriteimage:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:v2.layer];
    [self addSpriteimage:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:v3.layer];
    [self addSpriteimage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:v4.layer];
}

- (void)addSpriteimage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer {
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResize;
    layer.contentsRect = rect;
}

#pragma mark - contentsCenter 边角不拉伸
- (void)contentsCenter {
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(10, 100, 300, 100);
    button1.backgroundColor = [UIColor redColor];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(100, 300, 100, 300);
    button2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button2];
    
    UIImage *image = [UIImage imageNamed:@"button"];
    [self addStretchableImage:image withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:button1.layer];
    [self addStretchableImage:image withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:button2.layer];
}

- (void)addStretchableImage:(UIImage *)image withContentCenter:(CGRect)rect toLayer:(CALayer *)layer{
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsCenter = rect;
}

#pragma mark - Custom Drawimg

- (void)customDrawimg {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //创建父layer
    CALayer *bluelayer = [CALayer layer];
    bluelayer.frame = CGRectMake(50, 50, 100, 100);
    bluelayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //设置代理
    bluelayer.delegate = self;
    
    //添加layer到视图
    bluelayer.contentsScale = [UIScreen mainScreen].scale;
    [view.layer addSublayer:bluelayer];
    
    //开始绘制图层
    [bluelayer display];
}
//实现其代理
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 10);// 有宽度的圆
//    CGContextSetLineJoin(ctx, 10.);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

#pragma mark - 图层几何学































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
