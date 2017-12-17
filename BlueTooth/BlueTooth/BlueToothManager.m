//
//  BlueToothManager.m
//  BlueTooth
//
//  Created by GhostClock on 2017/12/16.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import "BlueToothManager.h"

typedef void(^BlueToothArrayBlock)(NSMutableArray *blePerArray);

@interface BlueToothManager()<CBCentralManagerDelegate, CBPeripheralDelegate>{
    BlueToothArrayBlock _blueToothArrayBlock;
}

@property (strong, nonatomic) CBCentralManager *manager;///< 中央设备
@property (assign, nonatomic) BluetoothFailState bluetoothFailState;///< 失败状态
@property (assign, nonatomic) BluetoothState bluetoothState;///< 连接状态
@property (strong, nonatomic) CBPeripheral *discoverPeripheral;///< 周边设备
@property (strong, nonatomic) CBCharacteristic *characteristicl;///< 周边设备服务特性
@property (retain, nonatomic) NSMutableArray *bleViewPerArray;

@end


@implementation BlueToothManager

+ (instancetype)shanderManager {
    static BlueToothManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BlueToothManager alloc]init];
    });
    return manager;
}

- (void)initWithBlueTooth {
    if (!self.manager) {
        self.manager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
        self.manager.delegate = self;
        self.bleViewPerArray = [[NSMutableArray alloc]initWithCapacity:1];
    }
}

- (void)scaning {
    [self.manager scanForPeripheralsWithServices:nil options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @NO}];
    //记录目前扫描的状态
    self.bluetoothState = BluetoothStateScaning;
    if (self.bluetoothFailState == BluetoothFailStateByOff) {
        NSLog(@"检查您的蓝牙是否开启……然后重试");
    }
}

- (void)stop {
    [self.manager stopScan];
}

//检查蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state != CBManagerStatePoweredOn) {
        NSLog(@"失败, 蓝牙状态是关闭状态");
        switch (central.state) {
            case CBManagerStatePoweredOff:
                NSLog(@"连接失败\n请检查你的手机是否开启蓝牙, 然后再重试一次");
                self.bluetoothFailState = BluetoothFailStateByOff;
                break;
                
            case CBManagerStateResetting:
                NSLog(@"连接失败\n扫描超时");
                self.bluetoothFailState = BluetoothFailStateTimeout;
                break;
            case CBManagerStateUnsupported:
                NSLog(@"连接失败\n检测到您的手机不支持蓝牙4.0");
                self.bluetoothFailState = BluetoothFailStateByHW;
                break;
            case CBManagerStateUnauthorized:
                NSLog(@"连接失败\n连接未授权");
                self.bluetoothFailState = BluetoothFailStateUnauthorized;
                break;
            case CBManagerStateUnknown:
                NSLog(@"连接失败\n发生未知错误");
                self.bluetoothFailState = BluetoothFailStateUnKnow;
                break;
            default:
                break;
        }
        return;
    }
    self.bluetoothFailState = BluetoothFailStateUnExit;
    //开始扫描
    NSLog(@"开始扫描……");
    [self scaning];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:@[peripheral, RSSI]  forKey:peripheral.identifier];
    
    for (int i = 0; i < self.bleViewPerArray.count; i ++) {
        NSDictionary *perDict = self.bleViewPerArray[i];
        for (NSUUID *uuid in perDict) {
            if (uuid == peripheral.identifier) {
                [self.bleViewPerArray removeObjectAtIndex:i];
            }
        }
    }
    [self.bleViewPerArray addObject:dict];
    if (_blueToothArrayBlock) {
        _blueToothArrayBlock(self.bleViewPerArray);
    }
}

- (void)getBlueToothData:(void (^)(NSMutableArray *))blueToothData{
    _blueToothArrayBlock = [blueToothData copy];
}

#pragma mark - 连接设备后

- (void)connectPeripheral:(CBPeripheral *)peripheral {
    [self.manager connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES}];
    self.discoverPeripheral = peripheral;
    self.discoverPeripheral.delegate = self;
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"%@", peripheral);
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
    
    NSLog(@"连接上了");
    _bluetoothState = BluetoothStateConnected;
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (error) {
        NSLog(@"连接的失败有错误 %@", [error localizedDescription]);
        return;
    }
    NSLog(@"所有的服务的serviceUUID %@", peripheral.services);
    
    //遍历所有服务
    for (CBService *service in peripheral.services) {
        NSLog(@"服务: %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
    NSLog(@"此时链接的peripheral：%@",peripheral);
}




@end
