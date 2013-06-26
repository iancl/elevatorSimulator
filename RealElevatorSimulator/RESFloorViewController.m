//
//  RESFloorViewController.m
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/14/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RESFloorViewController.h"
#import "RESFloorPanelViewController.h"
#import "RESFloorDoorsManager.h"
#import "RESFloorPanelManager.h"
#import "RESDoorsViewController.h"


@implementation RESFloorViewController
@synthesize floorNumber;

-(id)initWithFloorNumber: (NSString *)flNumber{
    self = [super init];
    
    if (self) {
        
        floorNumber = flNumber;
        
        // set background image pattern
        UIImage *image = [UIImage imageNamed:@"brickTexture.jpg"];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
        
        //build floor border
        [self buildFloorBorder];
        
        //add and pos panel
        [self addAndPositionPanel];
        
        //add and position doors
        [self addAndPositionDoors];
        
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

#pragma mark PRIVATE METHODS

-(void)addAndPositionDoors{
    RESDoorsViewController *doors = [[RESFloorDoorsManager floorDoorsManager] createDoorsForFloor:floorNumber];
    
    CGRect floorFrame = [self.view frame];
    CGRect panelFrame = [doors.view frame];
    
    [doors.view setFrame:CGRectMake(floorFrame.size.width / 2 - panelFrame.size.width / 2, floorFrame.size.height - panelFrame.size.height, panelFrame.size.width, panelFrame.size.height)];
    
    [self.view addSubview:doors.view];
}

-(void)addAndPositionPanel{
    
    RESFloorPanelViewController *panel = [[RESFloorPanelManager floorPanelManager] createFloorPanelForFloor:floorNumber];
    
    CGRect floorFrame = [self.view frame];
    CGRect panelFrame = [panel.view frame];
    
    [panel.view setFrame:CGRectMake(floorFrame.size.width / 2 + panelFrame.size.width, panelFrame.size.height / 2 , panelFrame.size.width, panelFrame.size.height)];
    
    [self.view addSubview:panel.view];

}

-(void)buildFloorBorder{
    CALayer *bottomBorder = [CALayer layer];
    
    CGRect viewFrame = [self.view frame];
    
    [bottomBorder setBackgroundColor:[UIColor blackColor].CGColor];
    [bottomBorder setFrame:CGRectMake(0, 0, viewFrame.size.width, 20)];
    
    [self.view.layer addSublayer:bottomBorder];
}

@end
