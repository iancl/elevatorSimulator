//
//  RESCageViewController.h
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/14/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RESCageViewControllerProtocol <NSObject>

@required
-(void)elevatorArrivedAtNextFloor;

@end

@interface RESCageViewController : UIViewController

@property (nonatomic, readonly) BOOL isCageMoving;
@property(nonatomic, readonly) int currentFloor;
@property (nonatomic) float floorHeight;
@property (nonatomic) int floorQty;
@property(nonatomic, weak) id<RESCageViewControllerProtocol> delegate;

-(void)moveElevatorToFloor: (int)flNumber animated: (BOOL)shoudAnim;
@end
