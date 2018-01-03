//
//  PopViewController.m
//  自定义转场-OC
//
//  Created by GhostClock on 2017/12/29.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import "PopViewController.h"
#import "GCNavigationDelegate.h"

@interface PopViewController ()

@property (strong, nonatomic) UIScreenEdgePanGestureRecognizer *edgePanGesture;
@property (strong, nonatomic) GCNavigationDelegate *navigationDelegate;

@end

@implementation PopViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc]init];
        self.navigationDelegate = [[GCNavigationDelegate alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Pop";
    [self createButton];
    self.edgePanGesture.edges = UIRectEdgeLeft;
    [self.edgePanGesture addTarget:self action:@selector(handleEdgePanGesture:)];
    [self.view addGestureRecognizer:self.edgePanGesture];
}

- (void)handleEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    CGFloat translationX = [gesture translationInView:self.view].x;
    CGFloat translationBase = self.view.frame.size.width / 3;
    CGFloat translationAbs = translationX > 0 ? translationX : -translationX;
    CGFloat percent = translationAbs > translationBase ? 1.0 : translationAbs / translationBase;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.navigationDelegate = self.navigationController.delegate;
            self.navigationDelegate.interaction = YES;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [self.navigationDelegate.interactionController updateInteractiveTransition:percent];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            if (percent > 0.5) {
                [self.navigationDelegate.interactionController finishInteractiveTransition];
            } else {
                [self.navigationDelegate.interactionController cancelInteractiveTransition];
            }
            self.navigationDelegate.interaction = NO;
            break;
        default:
            break;
    }
}


- (void)createButton {
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pushButton.frame = CGRectMake(0, 0, 100, 50);
    pushButton.center = self.view.center;
    [pushButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [pushButton setTitle:@"pop" forState:UIControlStateNormal];
    pushButton.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:pushButton];
}

- (void)buttonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [self.edgePanGesture removeTarget:self action:@selector(handleEdgePanGesture:)];
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
