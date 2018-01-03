//
//  GCScaleTransition.m
//  自定义转场-OC
//
//  Created by GhostClock on 2018/1/2.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "GCScaleTransition.h"

@implementation GCScaleTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    [containerView addSubview:toView];
    
    [[transitionContext containerView] bringSubviewToFront:fromView];
    
    NSTimeInterval time = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:time animations:^{
        fromView.alpha = 0.0;
        fromView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformMakeScale(1, 1);
        [transitionContext completeTransition:YES];
    }];
}



@end
