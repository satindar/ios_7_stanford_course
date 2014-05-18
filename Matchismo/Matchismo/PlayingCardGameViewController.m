//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/18/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
