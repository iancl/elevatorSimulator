//
//  RESMainPanelViewController.m
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/19/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RESMainPanelViewController.h"


@implementation RESMainPanelViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setDelegate:(id)aDelegate{
    if (delegate != aDelegate) {
        delegate = aDelegate;
    }
}

-(void)turnOnButtonLightOfButtonWithFloorNumber: (NSString *)flNumber{
    int floor = [flNumber intValue] - 1;
    
    [self turnOnButtonLightOfButton:[allButtons objectAtIndex:floor]];
}

-(void)turnOnButtonLightOfButton: (UIButton *)btn{
    [btn setBackgroundColor:[UIColor greenColor]];
}
-(void)turnOffButtonLightOfButtonWithFloorNumber: (NSString *)flNumber{
    int floor = [flNumber intValue] - 1;
    
    [[allButtons objectAtIndex:floor] setBackgroundColor:[UIColor darkGrayColor]];
}

-(IBAction)buttonTapped:(id)sender{
    switch ([sender tag]) {
        case 5:
            [delegate shouldCloseDoor];
            break;
            
        default:
           //[self turnOnButtonLightOfButton:sender];
            [delegate elevatorStopRequestedAtFloor:[NSString stringWithFormat:@"%ld", (long)[sender tag]]];
            break;
    }
}

@end
