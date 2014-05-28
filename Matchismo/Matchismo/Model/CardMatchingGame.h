//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/15/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

@property (nonatomic,readonly) NSInteger score;
@property (nonatomic) NSInteger pointsLastScored;
@property (nonatomic) NSInteger cardsToMatchInCurrentGameMode;
@property (nonatomic, strong) NSMutableArray *lastCardsPlayed;

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck*)deck
        cardsToMatchInCurrentMode:(NSUInteger)numberOfCards;

- (void)chooseCardAtIndex:(NSInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

- (void)addCardsIntoPlay:(NSUInteger)numberOfCardsToAdd;
- (NSUInteger)numberOfCardsInPlay;


@end
