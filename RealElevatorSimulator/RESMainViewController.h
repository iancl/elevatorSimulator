//
//  RESMainViewController.h
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/13/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESCageViewController.h"
#import "RESMainPanelViewController.h"

//testing

//end testing

@interface RESMainViewController : UIViewController<RESCageViewControllerProtocol, RESMainPanelViewControllerProtocol>{
    
    RESCageViewController *elevatorCage;
    RESMainPanelViewController *mainPanel;
    
    NSMutableDictionary *floorQueue;
    
    float floorHeight;
    
    BOOL isElevatorGoingUp;
    BOOL isElevatorReadyToleave;
    
    //testing
    
    //end testing
    
}


//will be called when an floors' doors are closed and the elevator is ready to move
-(void)elevatorReadyToLeaveFloor: (NSString *)flNumber;

//will be called when a floor panels direction button has been pressed
-(void)floorPanelButtonWasPressedWithDirecion: (char)direction floorNumber: (NSString *)flNumber;

//testing

//end testing

@end
