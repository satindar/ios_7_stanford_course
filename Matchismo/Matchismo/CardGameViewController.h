//
//  CardGameViewController.h
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/15/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//
// Abstract class must implement methods as described below

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;

- (void)newGame;

// protected
// for subclasses
- (Deck *)createDeck; // abstract

@end
