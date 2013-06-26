//
//  RESDoorsViewController.h
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/13/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RESDoorsViewController : UIViewController{
    
    //layers will be used as doors
    CALayer *leftDoor;
    CALayer *rightDoor;
    
    //flag will be used to know if the doors are animating
    BOOL areDoorsMoving;
    
    BOOL areDoorsOpen;
    
}

@property (nonatomic, strong) NSString *floorNumber;

-(void)openDoors;
-(void)closeDoors;

@end
