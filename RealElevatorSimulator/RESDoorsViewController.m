//
//  RESDoorsViewController.m
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/13/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RESDoorsViewController.h"
#import "RESFloorDoorsManager.h"

@interface RESDoorsViewController ()

@end

@implementation RESDoorsViewController
@synthesize floorNumber;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // set flags default value
        areDoorsMoving = NO;
        areDoorsOpen = NO;
        
        //creating doors
        [self buildDoors];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
}

#pragma mark PRIVATE METHODS

/**
 * All this methods will open or close each door
 */
-(void)openLeftDoor{
    [self moveDoorToLeft:leftDoor];
}

-(void)openRightDoor{
    [self moveDoorToRight:rightDoor];
}

-(void)closeRightDoor{
    [self moveDoorToRight:leftDoor];
}
-(void)closeLeftDoor{
    [self moveDoorToLeft:rightDoor];
}

/**
 * Creates two layers that will act like the sliding doors and adds it to the view layers
 *
 * @return void
 */
-(void)buildDoors{
    
    CGRect viewFrame = [self.view frame];
    CGRect leftDoorFrame = CGRectMake(0, 0, viewFrame.size.width /2, viewFrame.size.height);
    CGRect rightDoorFrame = CGRectMake(0, 0, viewFrame.size.width /2, viewFrame.size.height);
    
    //left door related
    leftDoor = [CALayer layer];
    leftDoorFrame.origin.x = leftDoorFrame.origin.x - 1;
    [leftDoor setFrame:leftDoorFrame];
    [leftDoor setBackgroundColor:[UIColor grayColor].CGColor];
    
    //right door related
    rightDoor = [CALayer layer];
    rightDoorFrame.origin.x = (viewFrame.size.width) - (rightDoorFrame.size.width - 1);
    [rightDoor setBackgroundColor:[UIColor grayColor].CGColor];
    [rightDoor setFrame:rightDoorFrame];
    
    //adding layers to main layer
    [[self.view layer] addSublayer:leftDoor];
    [[self.view layer] addSublayer:rightDoor];
}

/**
 * This method will move any door to the left
 * @param CALayer *door the door that will be moved
 *
 * @return void
 */
-(void)moveDoorToLeft: (CALayer *)door{
    
    //create animation
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    
    //creating coordinates for start and final position
    CGPoint currentPos = [door position];
    CGPoint finalPos = CGPointMake(currentPos.x - door.frame.size.width, currentPos.y);
    
    //setting animation values
    [anim setDuration:1.0];
    [anim setRepeatCount:0];
    [anim setFromValue:[NSValue valueWithCGPoint:currentPos]];
    [anim setToValue:[NSValue valueWithCGPoint:finalPos]];
    [anim setDelegate:self];
    anim.removedOnCompletion = NO;
    //setting final position
    [door setPosition:finalPos];
    
    //adding animaton
    [door addAnimation:anim forKey:@"moveToLeft"];
}


/**
 * This method will move any door to the right
 * @param CALayer *door the door that will be moved
 *
 * @return void
 */
-(void)moveDoorToRight: (CALayer *)door{
    
    //create animation
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    
    //creating coordinates for start and final position
    CGPoint currentPos = [door position];
    CGPoint finalPos = CGPointMake(currentPos.x + door.frame.size.width, currentPos.y);
    
    //setting animation values
    [anim setDuration:1.0];
    [anim setRepeatCount:0];
    [anim setFromValue:[NSValue valueWithCGPoint:currentPos]];
    [anim setToValue:[NSValue valueWithCGPoint:finalPos]];
    [anim setDelegate:self];
    
    //setting final position
    [door setPosition:finalPos];
    
    //adding animaton
    [door addAnimation:anim forKey:@"moveToRight"];
}

#pragma mark PUBLIC METHODS

/**
 * Public method that triggers closing the doors
 *
 * @return void
 */
-(void)closeDoors{
    
    //close doors if they are open and not moving
    if(areDoorsOpen && !areDoorsMoving){
        
        //setting flags value
        areDoorsOpen = NO;
        areDoorsMoving = YES;
        
        //closing doors
        [self closeLeftDoor];
        [self closeRightDoor];
    }
}


/**
 * Public method that triggers opening the doors
 *
 * @return void
 */
-(void)openDoors{
    
    //open doors if they are closed and not moving
    if (!areDoorsOpen && !areDoorsMoving){
        
        //setting flags value
        areDoorsOpen = YES;
        areDoorsMoving = YES;
        
        //opening doors
        [self openLeftDoor];
        [self openRightDoor];
    }
}

#pragma mark CAAnimation delegate methods

/**
 * filtering only move to left animation so the elevator doorsClosedAtFloor method will be called once only
 */
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    
    //doors stopped animating
    areDoorsMoving = NO;
    
   
    
    if(!areDoorsOpen && anim == [rightDoor animationForKey:@"moveToLeft"]){
        [[RESFloorDoorsManager floorDoorsManager] doorsClosedAtFloor:floorNumber];
    }
}

@end
