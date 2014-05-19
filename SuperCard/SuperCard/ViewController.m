//
//  ViewController.m
//  SuperCard
//
//  Created by SATINDAR S DHILLON on 5/18/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation ViewController

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.playingCardView.suit = @"♥";
    self.playingCardView.rank = 13;
    [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView
                                                
                                                                                         action:@selector(pinch:)]];
}

@end
