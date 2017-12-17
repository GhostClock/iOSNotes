//
//  TableViewCell.m
//  BlueTooth
//
//  Created by GhostClock on 2017/12/17.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import "TableViewCell.h"
#import <Masonry.h>

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        [self createUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)createUI {
    self.name = [[UILabel alloc]init];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(16);
    }];
    
    self.uuid = [[UILabel alloc]init];
    [self.contentView addSubview:self.uuid];
    [self.uuid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).offset(5);
        make.left.height.equalTo(self.name);
        make.width.equalTo(self.contentView.mas_width);
    }];
    
    self.signal = [[UILabel alloc]init];
    self.signal.textAlignment =NSTextAlignmentRight;
    [self.contentView addSubview:self.signal];
    [self.signal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.name);
        make.right.mas_equalTo(-10);
    }];
    
    
}

@end
