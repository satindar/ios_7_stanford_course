//
//  PlayingCard.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/15/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        id card = [otherCards firstObject];
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherCard = (PlayingCard *)card;
            if (otherCard.rank == self.rank) {
                score = 4;
            } else if ([otherCard.suit isEqualToString:self.suit]) {
                score = 1;
            }
        }
        
    } else if ([otherCards count] == 2) {
        id firstCardToMatch = [otherCards firstObject];
        id secondCardToMatch = [otherCards lastObject];
        if ([firstCardToMatch isKindOfClass:[PlayingCard class]] &&
            [secondCardToMatch isKindOfClass:[PlayingCard class]]) {
            PlayingCard *firstCard = (PlayingCard *)firstCardToMatch;
            PlayingCard *secondCard = (PlayingCard *)secondCardToMatch;
            
            if (firstCard.rank == secondCard.rank ||
                firstCard.rank == self.rank ||
                secondCard.rank == self.rank) {
                if ((self.rank == firstCard.rank) && (firstCard.rank == secondCard.rank)) {
                    score += 10;
                } else {
                    score += 2;
                }
            }
            
            if ([firstCard.suit isEqualToString:secondCard.suit] ||
                [firstCard.suit isEqualToString:self.suit] ||
                [secondCard.suit isEqualToString:self.suit]) {
                if ([firstCard.suit isEqualToString:secondCard.suit] &&
                    [secondCard.suit isEqualToString:self.suit]) {
                    score = +2;
                } else {
                    score = +1;
                }
            }
        }
    }
    return score;
}


- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (NSDictionary *)cardAttributes
{
    return nil;
}

@synthesize suit = _suit;


+ (NSArray *)validSuits
{
    return @[@"♣️", @"♥️", @"♦️", @"♠️"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end


