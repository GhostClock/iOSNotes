//
//  NextViewController.m
//  自定义转场-OC
//
//  Created by GhostClock on 2018/1/2.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "NextViewController.h"
#import "CustomAlertViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)createUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Pop";
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pushButton.frame = CGRectMake(0, 100, 100, 50);
    pushButton.center = self.view.center;
    [pushButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [pushButton setTitle:@"popPage" forState:UIControlStateNormal];
    pushButton.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:pushButton];
}

- (void)buttonAction:(UIButton *)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:[CustomAlertViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
