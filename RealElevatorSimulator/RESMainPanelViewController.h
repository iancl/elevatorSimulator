//
//  RESMainPanelViewController.h
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/19/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RESMainPanelViewControllerProtocol <NSObject>

@required
-(void)shouldCloseDoor;
-(void)elevatorStopRequestedAtFloor: (NSString *)flNumber;
@end

@interface RESMainPanelViewController : UIViewController{
    __weak IBOutlet UIButton *firstFloor;
    __weak IBOutlet UIButton *secondFloor;
    __weak IBOutlet UIButton *thirdFloor;
    __weak IBOutlet UIButton *fourthFloor;
    
    IBOutletCollection(UIButton) NSArray *allButtons;
}

@property (nonatomic, weak) id delegate;

-(IBAction)buttonTapped:(id)sender;

-(void)turnOnButtonLightOfButtonWithFloorNumber: (NSString *)flNumber;
-(void)turnOffButtonLightOfButtonWithFloorNumber: (NSString *)flNumber;
@end
