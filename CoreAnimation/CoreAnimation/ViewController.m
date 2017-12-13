//
//  ViewController.m
//  CoreAnimation
//
//  Created by GhostClock on 2017/12/13.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self Spriteimage];
}

//初探layer
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
//拆分图片显示
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
