//
//  SlideAnimationController.h
//  自定义转场-OC
//
//  Created by GhostClock on 2017/12/27.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger) {
    left = 0,
    right = 1,
}TabOperationDirection;

typedef NS_ENUM(NSUInteger) {
    presentation = 0,
    dismissal = 1,
}ModalOperation;

typedef struct{
    UINavigationControllerOperation navigationTransition;
    TabOperationDirection tabTransition;
    ModalOperation modalTransition;
}GCTransitionType;

@interface GCAnimationController : NSObject

@property (assign, nonatomic) GCTransitionType *transitionType;

- (void)setTransitionWithType:(GCTransitionType)type;

@end
