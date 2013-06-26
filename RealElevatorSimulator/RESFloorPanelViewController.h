//
//  RESFloorPanelViewController.h
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/13/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RESFloorPanelViewController : UIViewController{
    
    __weak IBOutlet UILabel *floorIndicator;
    __weak IBOutlet UIButton *upButton;
    __weak IBOutlet UIButton *downButton;
    
    BOOL isUpButtonOn;
    BOOL isDownButtonOn;
}

//floor number where the floor panel is located
@property (nonatomic, strong) NSString *floorNumber;

//this method will update the panel's floor indicator with the floor number param
-(void)updateFloorIndicatorWithNumber: (NSString *)flNumber;

//this will turn off the button light with the specified direction
-(void)turnOffButtonLightWithDirection: (char)direction;

//this will be called when any of the buttons is pressed
-(IBAction)buttonPressed:(id)sender;

@end
