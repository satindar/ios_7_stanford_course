//
//  SetGameViewController.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/19/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
#import "SetCard.h"

@interface SetGameViewController ()


@end

@implementation SetGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (UIView *)createCardViewUsingCard:(Card *)card
{
    SetCardView *cardView = [[SetCardView alloc] init];
    SetCard *setCard = (SetCard *)card;
    
    cardView.symbol = setCard.symbol;
    cardView.shading = setCard.shading;
    cardView.color = setCard.color;
    cardView.numberOfSymbolsToDisplay = setCard.rank;
    cardView.isChosen = setCard.isChosen;

    return cardView;
}

- (void)updateChosenProperty:(BOOL)cardIsChosen forCardView:(UIView *)cardView
{
    SetCardView *setCardView = (SetCardView *)cardView;
    setCardView.isChosen = cardIsChosen;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.maxCardSize = CGSizeMake(450, 300);
    self.initialCardCount = 12;
    self.numberOfCardsToMatch = 3;
    self.maxNumberOfCardsOnScreen = 21;
    self.maxCardsOnGrid = 30;
    [self newGame];
}

@end
