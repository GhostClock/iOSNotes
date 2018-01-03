//
//  GCNavigationViewController.m
//  自定义转场-OC
//
//  Created by GhostClock on 2017/12/29.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import "GCNavigationViewController.h"
#import "GCAnimationController.h"

@interface GCNavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation GCNavigationViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.interaction = NO;
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    GCAnimationController *gcAController = [[GCAnimationController alloc]init];
    gcAController.transitionType->navigationTransition = operation;
    [gcAController setTransitionWithType:*(gcAController.transitionType)];
    return (id)gcAController;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return _interaction ? _interactionController : nil;
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
