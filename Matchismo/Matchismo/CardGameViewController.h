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
@interface CardGameViewController : UIViewController

// protected
// for subclasses
- (Deck *)createDeck; // abstract

@end
