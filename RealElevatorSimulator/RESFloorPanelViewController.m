//
//  RESFloorPanelViewController.m
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/13/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RESFloorPanelViewController.h"
#import "RESFloorPanelManager.h"

@interface RESFloorPanelViewController ()

@end

@implementation RESFloorPanelViewController
@synthesize floorNumber;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // set flag initial values
        isDownButtonOn = NO;
        isDownButtonOn = NO;
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
 *
 * this will be called when any of the buttons is pressed
 *
 * @param UIButton that was pressed
 *
 * @return void
 */
-(IBAction)buttonPressed:(id)sender{
    
    char direction;
    
    switch ([sender tag]) {
        case 0: // upButton
            [self turnOnUpButtonLight];
            direction = 'u';
            break;
        case 1: //downButton
            [self turnOnDownButtonLight];
            direction = 'd';
            break;
    }
    
    [self buttonPressedWithDirection:direction];
    
}

/**
 * will change up button BGcolor and update flag
 */
-(void)turnOnUpButtonLight{
    if(!isUpButtonOn){
        isUpButtonOn = YES;
        
        [upButton setBackgroundColor:[UIColor greenColor]];
        
    }
}

/**
 * will change down button BGcolor and update flag
 */
-(void)turnOnDownButtonLight{
    if(!isDownButtonOn){
        isDownButtonOn = YES;
        
        [downButton setBackgroundColor:[UIColor greenColor]];
    }
}

/**
 * will change up button BGcolor and update flag
 */
-(void)turnOffUpButtonLight{
    if(isUpButtonOn){
        isUpButtonOn = NO;
        
        [upButton setBackgroundColor:[UIColor darkGrayColor]];
        
    }
}

/**
 * will change down button BGcolor and update flag
 */
-(void)turnOffDownButtonLight{
    if(isDownButtonOn){
        isDownButtonOn = NO;
        
        [downButton setBackgroundColor:[UIColor darkGrayColor]];
    }
}

/**
  * This will call a method on the floor panel manager and will pass the direction of the button that was pressed
  * and the floor number
  */
-(void)buttonPressedWithDirection: (char)direction{
    [[RESFloorPanelManager floorPanelManager] buttonPressedWithDirection:direction atFloor:floorNumber];
}

#pragma mark PUBLIC METHODS

/**
 *
 * this method will update the panel's floor indicator with the floor number param
 *
 * @param NSString *flNumber will be set to the label
 *
 * @return void
 */
-(void)updateFloorIndicatorWithNumber: (NSString *)flNumber{
    [floorIndicator setText:flNumber];
}


/**
 *
 * this will turn off the button light with the specified direction
 *
 * @param char direction will be used to find the right button
 *
 * @return void
 */
-(void)turnOffButtonLightWithDirection: (char)direction{
    switch (direction) {
        case 'u':
            [self turnOffUpButtonLight];
            break;
        case 'd':
            [self turnOffDownButtonLight];
            break;
            
        default:
            //do nothing
            break;
    }
}



@end
