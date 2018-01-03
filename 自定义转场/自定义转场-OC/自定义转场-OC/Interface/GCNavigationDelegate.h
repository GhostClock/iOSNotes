//
//  CGNavigationViewController.h
//  自定义转场-OC
//
//  Created by GhostClock on 2017/12/27.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GCNavigationDelegate : NSObject

@property (assign, nonatomic) BOOL interaction;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end
