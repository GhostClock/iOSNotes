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
    [[BlueToothManager shanderManager] getBlueToothData:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        [weakSelf insertTableView:peripheral advertisementData:advertisementData RSSI:RSSI];
    }];
}

//插入table数据
-(void)insertTableView:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSArray *peripherals = [self.dataSourceArray valueForKey:@"peripheral"];
    if (![peripherals containsObject:peripheral]) {
        NSMutableArray *indexPaths = [[NSMutableArray alloc]init];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexPaths.count inSection:0];
        [indexPaths addObject:indexPath];
        
        NSMutableDictionary *item = [[NSMutableDictionary alloc]init];
        [item setValue:peripheral forKey:@"peripheral"];
        [item setValue:RSSI forKey:@"RSSI"];
        [item setValue:advertisementData forKey:@"advertisementData"];
        [self.dataSourceArray addObject:item];
        
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
  
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
    
    CBPeripheral *peripheral = dict[@"peripheral"];
    NSNumber *RSSI = dict[@"RSSI"];
    NSDictionary *advertisementData = dict[@"advertisementData"];
    
    cell.name.text = [NSString stringWithFormat:@"%@", peripheral.name ];
    cell.uuid.text = [NSString stringWithFormat:@"%@", peripheral.identifier];
    cell.signal.text = [NSString stringWithFormat:@"%@", RSSI];
    
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
    CBPeripheral *periperal = dict[@"peripheral"];
    
    [[BlueToothManager shanderManager] connectPeripheral:periperal];
    ConnectViewController *connectVC = [[ConnectViewController alloc]init];
    [self.navigationController pushViewController:connectVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
