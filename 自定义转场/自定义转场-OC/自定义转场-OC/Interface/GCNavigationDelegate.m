//
//  CGNavigationViewController.m
//  自定义转场-OC
//
//  Created by GhostClock on 2017/12/27.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import "GCNavigationDelegate.h"
#import "GCAnimationController.h"

@interface GCNavigationDelegate() <UINavigationControllerDelegate>

@end

@implementation GCNavigationDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        self.interaction = NO;
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
    }
    return self;
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

@end
