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

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
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
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against other chosen cards
            // create array of matched cards
            
            NSArray *cardsToCompare = [self chosenAndUnmatchedCards];
            if ([self readyToCalculateScore:cardsToCompare]) {
                int matchScore = [card match:cardsToCompare];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    for (Card *otherCard in cardsToCompare) {
                        otherCard.matched = YES;
                    }
                    card.matched = YES;
                } else {
                    self.score -= MISMATCH_PENALTY; // for each card perhaps?
                    for (Card *otherCard in cardsToCompare) {
                        otherCard.chosen = NO;
                    }
                }
                
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (BOOL)readyToCalculateScore:(NSArray *)cardsToCompare
{
    BOOL readyToCompare = NO;
    if (self.threeCardMode == NO) {
        if ([cardsToCompare count] == 1) {
            readyToCompare = YES;
        }
    } else if ([cardsToCompare count] == 2) {
        readyToCompare = YES;
    }
    
    return readyToCompare;
}

- (NSArray *)chosenAndUnmatchedCards
{
    NSMutableArray *otherCards = [NSMutableArray array];
    for (Card *card in self.cards) {
        if (card.isChosen && !card.isMatched) {
            [otherCards addObject:card];
        }
    }
    return otherCards;
}

@end
