//
//  RESMainViewController.m
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/13/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RESMainViewController.h"
#import "RESFloorDoorsManager.h"
#import "RESFloorPanelManager.h"
#import "RESFloorPanelViewController.h"
#import "RESFloorViewController.h"

@interface RESMainViewController ()
    
@end

@implementation RESMainViewController

//DEFINING CONSTANTS
const int FLOOR_COUNT = 4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        floorHeight = 0;
        isElevatorGoingUp = YES;
        isElevatorReadyToleave = YES;
        
        NSMutableArray *upQueue = [[NSMutableArray alloc] init];
        NSMutableArray *downQueue = [[NSMutableArray alloc] init];
        
        floorQueue = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:upQueue, downQueue, nil] forKeys:[NSArray arrayWithObjects:@"up", @"down", nil]];
        
        // init floor and door managers and set elevatorController properties
        [[RESFloorDoorsManager floorDoorsManager] setElevatorController:self];
        [[RESFloorPanelManager floorPanelManager] setElevatorController:self];
        
        //adding floors
        [self addAllFloors];
        
        //mainPanel related
        mainPanel = [[RESMainPanelViewController alloc] init];
        [mainPanel setDelegate:self];
        [self.view addSubview:mainPanel.view];
        
        //elevator cage related
        elevatorCage = [[RESCageViewController alloc] init];
        [elevatorCage setFloorQty:FLOOR_COUNT];
        [elevatorCage setFloorHeight:floorHeight];
        [elevatorCage setDelegate:self];
        [self addChildViewController:elevatorCage];
        [self.view addSubview:elevatorCage.view];
        
        //moving elevator to first floor
        [elevatorCage moveElevatorToFloor:1 animated:NO];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark PUBLIC METHODS

/**
 * will be called when an floors' doors are closed and the elevator is ready to move
 *
 * @param NSString *flNumber the floor where the elevator is currently at
 * flNumber will need to be parsed to int
 *
 * @return void
 */
-(void)elevatorReadyToLeaveFloor: (NSString *)flNumber{
     isElevatorReadyToleave = YES;
    [self moveElevatorToNextFloor];
}

/**
 * will be called when a floor panels direction button has been pressed
 *
 * @param NSString *flNumber the floor where the elevator is currently at
 * @param char direction 'u' for up and 'd' for down 
 *
 * flNumber will need to be parsed to int
 *
 * @return void
 */
-(void)floorPanelButtonWasPressedWithDirecion: (char)direction floorNumber: (NSString *)flNumber{
    
    NSString *key = direction == 'u' ? @"up" : @"down";
    
    NSMutableArray *queue = [floorQueue objectForKey:key];
    
    
    if (![queue containsObject:flNumber]) {
        [queue addObject:flNumber];
    }
    
    [mainPanel turnOnButtonLightOfButtonWithFloorNumber:flNumber];
    
    [self moveElevatorToNextFloor];
}


#pragma mark PRIVATE METHODS




-(void)addAllFloors{
    
    CGRect viewFrame = self.view.frame;
    
    for (int i = 0; i < FLOOR_COUNT; i++) {
        
        RESFloorViewController *floor = [[RESFloorViewController alloc] initWithFloorNumber:[NSString stringWithFormat:@"%i", (i+1)]];
        
        if(floorHeight < 1){
            floorHeight = floor.view.frame.size.height;
        }
        
        CGRect floorFrame = floor.view.frame;
        
        [floor.view setFrame:CGRectMake(0, viewFrame.size.height - (floorHeight * (i+1)), floorFrame.size.width, floorFrame.size.height)];
        
        [self addChildViewController:floor];
        [self.view addSubview:floor.view];
        floor = nil;
    }
    
}


-(void)moveElevatorToNextFloor{
    
    if(!isElevatorReadyToleave) return;
    
    
    
    NSArray *upQueue = [floorQueue objectForKey:@"up"];
    NSArray *downQueue = [floorQueue objectForKey:@"down"];
    
    if([upQueue count] < 1 && isElevatorGoingUp){
        isElevatorGoingUp = NO;
    }
    
    if([downQueue count] < 1 && !isElevatorGoingUp){
        isElevatorGoingUp = YES;
    }
    
    if([upQueue count] > 0 && isElevatorGoingUp){
        [elevatorCage moveElevatorToFloor:[[upQueue objectAtIndex:0] intValue] animated:YES];
        [[RESFloorPanelManager floorPanelManager] updateAllFloorPanelIndicatorsWithFloorNumber:[upQueue objectAtIndex:0]];
        isElevatorReadyToleave = NO;
    } else if ([downQueue count] > 0) {
        [elevatorCage moveElevatorToFloor:[[downQueue objectAtIndex:0] intValue] animated:YES];
         [[RESFloorPanelManager floorPanelManager] updateAllFloorPanelIndicatorsWithFloorNumber:[downQueue objectAtIndex:0]];
        isElevatorReadyToleave = NO;
    }
}

#pragma mark elevatorCage protocol

-(void)elevatorArrivedAtNextFloor{
    
    
    NSMutableArray *downQueue = [floorQueue objectForKey:@"down"];
    NSMutableArray *upQueue = [floorQueue objectForKey:@"up"];
    NSString *floorNumber;
    
    if ([upQueue count] > 0 && isElevatorGoingUp) {
        
        [[RESFloorPanelManager floorPanelManager] turnOffButtonLightWithDirection:'u' atFloor:[upQueue objectAtIndex:0]];
        
        floorNumber = [NSString stringWithFormat:@"%@", [upQueue objectAtIndex:0]];
    } else if([downQueue count] > 0) {
        [[RESFloorPanelManager floorPanelManager] turnOffButtonLightWithDirection:'d' atFloor:[downQueue objectAtIndex:0]];
        
        floorNumber = [NSString stringWithFormat:@"%@", [downQueue objectAtIndex:0]];
    }
    
    [[RESFloorDoorsManager floorDoorsManager] openDoorsAtFloor:floorNumber];
    [mainPanel turnOffButtonLightOfButtonWithFloorNumber:floorNumber];
    
    [self moveElevatorToNextFloor];
}


#pragma mark mainPanelProtocol Methods
-(void)shouldCloseDoor{
    NSMutableArray *downQueue = [floorQueue objectForKey:@"down"];
    NSMutableArray *upQueue = [floorQueue objectForKey:@"up"];
    NSString *floorNumber;
    
    if ([upQueue count] > 0 && isElevatorGoingUp) {
        floorNumber = [NSString stringWithFormat:@"%@", [upQueue objectAtIndex:0]];
        [upQueue removeObjectAtIndex:0];
    } else if([downQueue count] > 0) {
        floorNumber = [NSString stringWithFormat:@"%@", [downQueue objectAtIndex:0]];
        [downQueue removeObjectAtIndex:0];
    }
    
    [[RESFloorDoorsManager floorDoorsManager] closeDoorsAtFloor:floorNumber];
}


-(void)elevatorStopRequestedAtFloor: (NSString *)flNumber{
    NSMutableArray *downQueue = [floorQueue objectForKey:@"down"];
    NSMutableArray *upQueue = [floorQueue objectForKey:@"up"];
    int currFlor = [elevatorCage currentFloor];
    int requestedFlNumStop = [flNumber integerValue];
    char direction = '0';

    if(requestedFlNumStop < currFlor){
        [upQueue addObject:flNumber];
        direction = 'u';
    } else if(requestedFlNumStop == currFlor){
        [[RESFloorDoorsManager floorDoorsManager] openDoorsAtFloor:flNumber];
        [mainPanel turnOffButtonLightOfButtonWithFloorNumber:flNumber];
    } else if(requestedFlNumStop > currFlor){
        [downQueue addObject:flNumber];
        direction = 'd';
    }
    
    if(direction != '0'){
        [self floorPanelButtonWasPressedWithDirecion:direction floorNumber:flNumber];
    }
    
    
}


@end
