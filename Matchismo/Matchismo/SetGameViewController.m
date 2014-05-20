//
//  SetGameViewController.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/19/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

@end
