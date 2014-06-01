//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/18/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (UIView *)createCardViewUsingCard:(Card *)card
{
    PlayingCardView *cardView = [[PlayingCardView alloc] init];
    PlayingCard *playingCard = (PlayingCard *)card;
    
    cardView.rank = playingCard.rank;
    cardView.suit = playingCard.suit;
    cardView.faceUp = NO;
    
    return cardView;
}


- (void)updateChosenProperty:(BOOL)cardIsChosen andMatchedProperty:(BOOL)cardIsMatched forCardView:(UIView *)cardView
{
    PlayingCardView *playingCardView = (PlayingCardView *)cardView;
    playingCardView.isMatched = cardIsMatched;
    
    if (playingCardView.faceUp != cardIsChosen) {
        [UIView transitionWithView:playingCardView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^(void) {
                            playingCardView.faceUp = cardIsChosen;
                        }
                        completion:nil
         ];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.maxCardSize = CGSizeMake(300, 450);
    self.initialCardCount = 25;
    self.numberOfCardsToMatch = 3;
    self.maxNumberOfCardsOnScreen = self.initialCardCount;
    self.maxCardsOnGrid = self.maxNumberOfCardsOnScreen;
    [self newGame];
}

@end
