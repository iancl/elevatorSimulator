//
//  RESFloorViewController.h
//  RealElevatorSimulator
//
//  Created by Ian Calderon on 6/14/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RESFloorViewController : UIViewController


@property (nonatomic, strong) NSString *floorNumber;


-(id)initWithFloorNumber: (NSString *)flNumber;
@end
