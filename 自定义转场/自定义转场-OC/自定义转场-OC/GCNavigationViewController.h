//
//  GCNavigationViewController.h
//  自定义转场-OC
//
//  Created by GhostClock on 2017/12/29.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCNavigationViewController : UINavigationController

@property (assign, nonatomic) BOOL interaction;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end
