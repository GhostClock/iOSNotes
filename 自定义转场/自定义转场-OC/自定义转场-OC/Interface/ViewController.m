//
//  ViewController.m
//  自定义转场-OC
//
//  Created by GhostClock on 2017/12/27.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title = @"Push";
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pushButton.frame = CGRectMake(0, 0, 100, 50);
    pushButton.center = self.view.center;
    [pushButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [pushButton setTitle:@"pushPage" forState:UIControlStateNormal];
    pushButton.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:pushButton];
}

- (void)buttonAction:(UIButton *)sender {
    [self.navigationController pushViewController:[NextViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
