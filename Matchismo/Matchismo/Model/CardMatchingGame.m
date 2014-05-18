//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/15/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)lastCardsPlayed
{
    if (!_lastCardsPlayed) _lastCardsPlayed = [[NSMutableArray alloc] init];
    return _lastCardsPlayed;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
        cardsToMatchInCurrentMode:(NSUInteger)numberOfCards
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        self.cardsToMatchInCurrentGameMode = numberOfCards;
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSInteger)index
{
    Card *card = [self cardAtIndex:index];
    [self.lastCardsPlayed addObject:card];
    int pointsScored = 0;
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSArray *cardsToCompare = [self chosenAndUnmatchedCards];
            if ([self readyToCalculateScore:cardsToCompare]) {
                int matchScore = [card match:cardsToCompare];
                if (matchScore) {
                    pointsScored += matchScore * MATCH_BONUS;
                    for (Card *otherCard in cardsToCompare) {
                        otherCard.matched = YES;
                    }
                    card.matched = YES;
                } else {
                    pointsScored -= MISMATCH_PENALTY; // for each card perhaps?
                    for (Card *otherCard in cardsToCompare) {
                        otherCard.chosen = NO;
                    }
                }
            }
            pointsScored -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    self.score += pointsScored;
    self.pointsLastScored = pointsScored;
}

- (BOOL)readyToCalculateScore:(NSArray *)cardsToCompare
{
    return ([cardsToCompare count] == self.cardsToMatchInCurrentGameMode - 1);
}

- (NSArray *)chosenAndUnmatchedCards
{
    NSMutableArray *otherCards = [NSMutableArray array];
    for (Card *card in self.cards) {
        if (card.isChosen && !card.isMatched) {
            [otherCards addObject:card];
            [self.lastCardsPlayed addObject:card];
        }
    }
    return otherCards;
}

@end
