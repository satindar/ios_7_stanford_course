//
//  SetCardGame.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/20/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "SetCardGame.h"

@interface SetCardGame()
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation SetCardGame

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

- (BOOL)readyToCalculateScore:(NSArray *)cardsToCompare
{
    return ([cardsToCompare count] == 3);
}




@end
