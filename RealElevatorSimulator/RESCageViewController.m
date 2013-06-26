//
//  RESCageViewController.m
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/14/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RESCageViewController.h"

@interface RESCageViewController ()

@end

@implementation RESCageViewController
@synthesize floorHeight, floorQty, delegate, currentFloor, isCageMoving;

-(id)init{
    self = [super init];
    
    if (self) {
        isCageMoving = NO;
    }
    
    return self;
}

-(void)setDelegate:(id<RESCageViewControllerProtocol>)aDelegate{
    if(delegate != aDelegate){
        delegate = aDelegate;
    }
}

-(void)moveElevatorToFloor: (int)flNumber animated: (BOOL)shoudAnim{

        if (shoudAnim && !isCageMoving) {
            isCageMoving = YES;
            [self addMovementAnimation:flNumber];
        } else {
            [self moveCage:flNumber];
        }
}

-(void)addMovementAnimation: (int)flNumber{
    [UIView animateWithDuration:2 animations:^{
        
        [self moveCage:flNumber];
        
    } completion:^(BOOL finished){
        isCageMoving = NO;
        [delegate elevatorArrivedAtNextFloor];
    }];
}

-(void)moveCage: (int)flNumber{
    CGRect viewFrame = [UIScreen.mainScreen bounds];
    CGRect cageFrame = [self.view frame];
    
    //removing 20 probably because of the 20px black layer
    
    [self.view setFrame:CGRectMake((viewFrame.size.width / 2) - (cageFrame.size.width / 2), viewFrame.size.height - cageFrame.size.height - 20 - (floorHeight * (flNumber-1)) , cageFrame.size.width, cageFrame.size.height)];
    currentFloor = flNumber;
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

@end
