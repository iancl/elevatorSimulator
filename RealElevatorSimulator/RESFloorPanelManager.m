//
//  RESFloorPanelManager.m
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/13/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RESFloorPanelManager.h"
#import "RESFloorPanelViewController.h"
#import "RESMainViewController.h"

@implementation RESFloorPanelManager
@synthesize elevatorController;
-(id)init{
    self = [super init];
    
    if(self){
        //init dictionary
        allFloorPanels = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

/**
 *
 * This method will make sure only one instance of this class is created
 *
 * @return RESFloorPanelManager floorPanelManager is new instance or the already
 * created instance
 **/
+(RESFloorPanelManager *)floorPanelManager{
    static RESFloorPanelManager *floorPanelManager = nil;
    
    if(!floorPanelManager){
        floorPanelManager = [[RESFloorPanelManager allocWithZone:nil] init];
    }
    
    return floorPanelManager;
}

/**
 * will create a new instace of RESFloorPanelViewController store in the dict and return it
 * If there is already an instance for the same key it will return it
 *
 * @return RESFloorPanelViewController floorPanel new or existing floor panel instance for the key
 */
-(RESFloorPanelViewController *)createFloorPanelForFloor: (NSString *)flNumber{

    RESFloorPanelViewController *floorPanel = [allFloorPanels objectForKey:flNumber];
    
    if(!floorPanel){
        floorPanel = [[RESFloorPanelViewController alloc] init];
        [allFloorPanels setObject:floorPanel forKey:flNumber];
        [floorPanel setFloorNumber:flNumber];
    }
    
    return floorPanel;
}

/**
 * will update all panel floor indicators with the flNumber provided
 *
 * @param NSString* flNumber floor number where the panel is located
 *
 * @return void
 */
-(void)updateAllFloorPanelIndicatorsWithFloorNumber: (NSString *)flNumber{
    
    for(NSString *key in allFloorPanels){
        RESFloorPanelViewController *panel = [allFloorPanels objectForKey:key];
        [panel updateFloorIndicatorWithNumber:flNumber];
        panel = nil;
    }
}

/**
 * turns off a direction button light at the provided flNumber
 *
 * @param NSString* flNumber floor number where the panel is located
 * @param char direction direction of the panel button light that needs to be turned off
 *
 * @return void
 */
-(void)turnOffButtonLightWithDirection: (char)direction atFloor: (NSString *)flNumber{
    
    RESFloorPanelViewController *floorPanel = [allFloorPanels objectForKey:flNumber];
    
    if(floorPanel){
        [floorPanel turnOffButtonLightWithDirection: direction];
    }
}

/**
 * will be called when a direction button has been pressed at any of the floors
 *
 * @param NSString* flNumber floor number where the panel is located
 * @param char direction direction of the the panel button that was pressed
 *
 * @return void
 */
-(void)buttonPressedWithDirection: (char)direction atFloor: (NSString *)flNumber{
    [elevatorController floorPanelButtonWasPressedWithDirecion:direction floorNumber:flNumber];
}

@end