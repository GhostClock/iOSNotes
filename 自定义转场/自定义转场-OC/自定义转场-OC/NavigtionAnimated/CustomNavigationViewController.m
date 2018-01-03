//
//  CustomNavigationViewController.m
//  自定义转场-OC
//
//  Created by GhostClock on 2018/1/3.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "CustomNavigationViewController.h"
#import "GCScaleTransition.h"

@interface CustomNavigationViewController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>
{
    id<UIGestureRecognizerDelegate> _delegate;
}
@end

@implementation CustomNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = [UIColor magentaColor];
    _delegate = self.navigationController.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

#pragma mark - 自定义导航栏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == navigationController.viewControllers[0]) {
        viewController.navigationController.interactivePopGestureRecognizer.delegate = nil;
    } else {
        viewController.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count >= 1) {
        [self.navigationItem setHidesBackButton:YES];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 4, 36, 36);
        [button setImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        viewController.navigationItem.leftBarButtonItem = leftBarItem;
        viewController.navigationItem.leftBarButtonItem.customView = button;
        
        leftBarItem.customView = button;
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    if (self.childViewControllers.count == 2) {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)backViewController {
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        [self backViewController];
        return YES;
    }
    return NO;
}

#pragma mark - 自定义push动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return [[GCScaleTransition alloc]init];
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
