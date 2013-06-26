//
//  RESFloorPanelManager.h
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/13/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RESMainViewController, RESFloorPanelViewController;

@interface RESFloorPanelManager : NSObject{
    
    //collection will hold a reference to all floor panel instances
    NSMutableDictionary *allFloorPanels;
}

//reference to main elevator controller
@property (nonatomic, weak) RESMainViewController *elevatorController;

//this method will create an instance or return the already created instance
+(RESFloorPanelManager *)floorPanelManager;

//this will create a floor panel intance, store it in the dictionary and return the reference
-(RESFloorPanelViewController *)createFloorPanelForFloor: (NSString *)flNumber;

//will update all panel floor indicators with the flNumber provided
-(void)updateAllFloorPanelIndicatorsWithFloorNumber: (NSString *)flNumber;

//turns off a direction button light at the provided flNumber
-(void)turnOffButtonLightWithDirection: (char)direction atFloor: (NSString *)flNumber;

//will be called when a direction button has been pressed at any of the floors
-(void)buttonPressedWithDirection: (char)direction atFloor: (NSString *)flNumber;

@end
