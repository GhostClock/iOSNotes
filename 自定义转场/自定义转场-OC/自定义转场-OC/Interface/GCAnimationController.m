//
//  SlideAnimationController.m
//  自定义转场-OC
//
//  Created by GhostClock on 2017/12/27.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import "GCAnimationController.h"

@interface GCAnimationController() <UIViewControllerAnimatedTransitioning>

@end

@implementation GCAnimationController


- (void)setTransitionWithType:(GCTransitionType)type {
    self.transitionType = &(type);
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *formView = fromVC.view;
    UIView *toView = toVC.view;
    
    CGFloat translation = containerView.frame.size.width;
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    
    GCTransitionType type = *(self.transitionType);
   
    if (type.navigationTransition) {
        translation = type.navigationTransition == UINavigationControllerOperationPush ? translation : -translation;
        toViewTransform = CGAffineTransformMakeTranslation(translation, 0);
        fromViewTransform = CGAffineTransformMakeTranslation(translation, 0);
    } else if (type.tabTransition) {
        translation = type.tabTransition == left ? translation : -translation;
        fromViewTransform = CGAffineTransformMakeTranslation(translation, 0);
        toViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
    } else if (type.modalTransition) {
        translation = containerView.frame.size.height;
        toViewTransform = CGAffineTransformMakeTranslation(0, (type.modalTransition == (type.modalTransition == presentation) ? translation : 0));
        fromViewTransform = CGAffineTransformMakeTranslation(0, (type.modalTransition == (type.modalTransition == presentation) ? translation : 0));
    }
    
    switch (type.modalTransition) {
        case presentation:
            [containerView addSubview:toView];
        case dismissal: break;
            
        default:
            [containerView addSubview:toView];
    }
    
    toView.transform = toViewTransform;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        formView.transform = fromViewTransform;
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        formView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:transitionContext.transitionWasCancelled];
    }];
}

@end
