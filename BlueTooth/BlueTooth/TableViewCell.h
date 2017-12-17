//
//  TableViewCell.h
//  BlueTooth
//
//  Created by GhostClock on 2017/12/17.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *uuid;
@property (strong, nonatomic) UILabel *signal;

@end
