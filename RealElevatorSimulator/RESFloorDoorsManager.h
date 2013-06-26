//
//  RESFloorDoorsManager.h
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/13/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RESMainViewController, RESDoorsViewController;

@interface RESFloorDoorsManager : NSObject{
    //dict will hold all references to doors
    NSMutableDictionary *allFloorDoors;
}

//reference to main controller
@property (nonatomic, weak) RESMainViewController *elevatorController;

//this method will create an instance or return the already created instance
+(RESFloorDoorsManager *)floorDoorsManager;

//to create doors and return the reference. the key will be the floors where the door will be
//located
-(RESDoorsViewController *)createDoorsForFloor: (NSString *)flNumber;

//to open doors at specific floor
-(void)openDoorsAtFloor: (NSString *)flNumber;

//to open doors at specific floor
-(void)closeDoorsAtFloor: (NSString *)flNumber;

//to let know when the doors or an specific floor just closed
-(void)doorsClosedAtFloor: (NSString *)flNumber;


@end
