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

@synthesize suit = _suit;
@synthesize symbol = _symbol;
@synthesize shading = _shading;
@synthesize color = _color;

+ (NSArray *)validSuits
{
    return @[@"♣️", @"♥️", @"♦️", @"♠️"];
}

+ (NSArray *)validSymbols
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validShadings
{
    return @[@"open", @"solid", @"outlined"];
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}


- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[PlayingCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

- (void)setShading:(NSString *)shading
{
    if ([[PlayingCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *)color
{
    return _color ? _color : @"?";
}

- (void)setColor:(NSString *)color
{
    if ([[PlayingCard validColors] containsObject:color]) {
        _color = color;
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


