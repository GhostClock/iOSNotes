//
//  ViewController.m
//  BlueTooth
//
//  Created by GhostClock on 2017/12/16.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import "ViewController.h"
#import "BlueToothManager.h"
#import "TableViewCell.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <Masonry.h>
#import "ConnectViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *dataSourceArray;

@end


@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [[BlueToothManager shanderManager] scaning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[BlueToothManager shanderManager] stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createTableView];
    self.view.backgroundColor = [UIColor orangeColor];
    [[BlueToothManager shanderManager] initWithBlueTooth];
    
    typeof(self)weakSelf = self;
    [[BlueToothManager shanderManager]getBlueToothData:^(NSMutableArray *blueToothDeviceArray) {
        weakSelf.dataSourceArray = blueToothDeviceArray;
        [weakSelf.tableView reloadData];
    }];
}

//创建TableView用以显示
- (void)createTableView {
    self.dataSourceArray = [[NSMutableArray alloc]initWithCapacity:1];
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSDictionary *dict = self.dataSourceArray[indexPath.row];
    for (NSUUID *uuid in dict) {
        NSArray *perArray = dict[uuid];
        CBPeripheral *peripheral = perArray[0];
        cell.name.text = [NSString stringWithFormat:@"%@", peripheral.name ? peripheral.name : @"未知设备"];
        cell.uuid.text = [NSString stringWithFormat:@"%@", peripheral.identifier];
        cell.signal.text = [NSString stringWithFormat:@"%@", perArray[1]];
    }
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[BlueToothManager shanderManager] stop];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [[BlueToothManager shanderManager] scaning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataSourceArray[indexPath.row];
    for (NSUUID *uuid in dict) {
        CBPeripheral *periperal = dict[uuid][0];
        [[BlueToothManager shanderManager] connectPeripheral:periperal];
        ConnectViewController *connectVC = [[ConnectViewController alloc]init];
        [self.navigationController pushViewController:connectVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
