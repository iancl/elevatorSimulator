//
//  RESFloorDoorsManager.m
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/13/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RESFloorDoorsManager.h"
#import "RESDoorsViewController.h"
#import "RESMainViewController.h"

@implementation RESFloorDoorsManager
@synthesize elevatorController;


//Custom initialization
-(id)init{
    self = [super init];
    
    if(self){
        
        //initializing dictionary
        allFloorDoors = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

/**
 *
 * This method will make sure only one instance of this class is created
 *
 * @return RESFloorDoorManger floorDoorManager will return a new instance or the already
 * created instance
 **/
+(RESFloorDoorsManager *)floorDoorsManager{
    
    static RESFloorDoorsManager *floorDoorsManager = nil;
    
    if(!floorDoorsManager){
        floorDoorsManager = [[RESFloorDoorsManager allocWithZone:nil] init];
    }
    
    return floorDoorsManager;
}


/**
 *
 * This method will create a new instance of RESFloorDoorsViewController, add it to the
 * allFloorDoors dictionary using the flNumber as key.
 * If there is already an instance for that key, it will return the already stored instance
 *
 * @param int flNumber this is the floor number where the doors will be located.
 * they will be used as a key to store the new instance
 *
 * @return RESFloorDoorManger floorDoorManager will return a new instance of the already
 * created instance
 **/
-(RESDoorsViewController *)createDoorsForFloor:(NSString *)flNumber{
    
    RESDoorsViewController *doors = [allFloorDoors objectForKey:flNumber];
    
    if(!doors){
        doors = [[RESDoorsViewController alloc] init];
        [doors setFloorNumber:flNumber];
        [allFloorDoors setObject:doors forKey:flNumber];
    }

    return doors;
}

/**
 *
 * This method will look for doors using the floorNumber as key and they will send
 * a message to them so they can open the doors
 *
 * @param int flNumber this is the floor number where the doors are be located.
 *
 * @return void
 **/
-(void)openDoorsAtFloor:(NSString *)flNumber{
    
    RESDoorsViewController *doors = [allFloorDoors objectForKey:flNumber];
    
    if(doors){
        [doors openDoors];
    }
}

/**
 *
 * This method will look for doors using the floorNumber as key and they will send
 * a message to them so they can close the doors
 *
 * @param int flNumber this is the floor number where the doors are be located.
 *
 * @return void
 **/
-(void)closeDoorsAtFloor:(NSString *)flNumber{
    
    RESDoorsViewController *doors = [allFloorDoors objectForKey:flNumber];
    
    if(doors){
        [doors closeDoors];
    }
}


/**
 *
 * This method will be called when doors from a specific floor just closed.
 * After that the elevatorController will be notified that the cage is ready to leave
 *
 * @param int flNumber this is the floor number where the doors are be located.
 *
 * @return void
 **/
-(void)doorsClosedAtFloor:(NSString *)flNumber{
    [elevatorController elevatorReadyToLeaveFloor: flNumber];
}

@end
