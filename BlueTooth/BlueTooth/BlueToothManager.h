//
//  BlueToothManager.h
//  BlueTooth
//
//  Created by GhostClock on 2017/12/16.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

// 蓝牙的状态
typedef NS_ENUM(NSInteger, BluetoothState) {
    BluetoothStateDisconnect = 0,
    BluetoothStateScanSuccess,
    BluetoothStateScaning,
    BluetoothStateConnected,
    BluetoothStateConnecting,
};

// 失败的原因
typedef NS_ENUM(NSInteger, BluetoothFailState) {
    BluetoothFailStateUnExit = 0,
    BluetoothFailStateUnKnow,
    BluetoothFailStateByHW,
    BluetoothFailStateByOff,
    BluetoothFailStateUnauthorized,
    BluetoothFailStateTimeout,
};

@interface BlueToothManager : NSObject

+ (instancetype)shanderManager;

- (void)initWithBlueTooth;///< 初始化蓝牙
- (void)scaning;///< 开始扫描
- (void)stop;///< 停止扫描
- (void)connectPeripheral:(CBPeripheral *)peripheral ;///< 连接设备


- (void)getBlueToothData:(void(^)(CBCentralManager *central,CBPeripheral *peripheral,NSDictionary *advertisementData, NSNumber *RSSI))blueToothData;

@end
