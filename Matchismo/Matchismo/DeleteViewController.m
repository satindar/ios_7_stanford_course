//
//  DeleteViewController.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/23/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "DeleteViewController.h"
#import "SetCardView.h"

@interface DeleteViewController ()
@property (weak, nonatomic) IBOutlet SetCardView *setCardView;

@end

@implementation DeleteViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.setCardView.symbol = @"square";
    self.setCardView.shading = @"unfilled";
    self.setCardView.color = @"purple";
    self.setCardView.numberOfSymbolsToDisplay = 3;
}

@end
