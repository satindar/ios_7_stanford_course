//
//  SetCard.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/20/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSString *)contents
{
    return nil;
}

@synthesize symbol = _symbol;
@synthesize shading = _shading;
@synthesize color = _color;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (SetCard *card in otherCards) {
        if ([self card:(SetCard *)card createsSetWithOtherCards:(NSArray *)otherCards]) {
            score = 1;
        }
    }
    
    return score;
}

- (BOOL)card:(SetCard *)card createsSetWithOtherCards:(NSArray *)otherCards
{
    // loop through each attribute
    NSMutableArray *allCards = [[NSMutableArray alloc] initWithArray:otherCards];
    [allCards addObject:card];

    if ([self cardAttributesSatisfySetConditions:[allCards valueForKeyPath:@"symbol"]] &&
        [self cardAttributesSatisfySetConditions:[allCards valueForKeyPath:@"shading"]] &&
        [self cardAttributesSatisfySetConditions:[allCards valueForKeyPath:@"color"]] &&
        [self cardAttributesSatisfySetConditions:[allCards valueForKeyPath:@"rank"]]) {
        return YES;
    }

    return NO;
}

- (BOOL)cardAttributesSatisfySetConditions:(NSArray *)attributeValues
{
    int attributeCount = [[[NSSet alloc] initWithArray:attributeValues] count];
    if (attributeCount == 1 || attributeCount == [attributeValues count]) {
        return YES;
    }
    return NO;
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

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *)color
{
    return _color ? _color : @"?";
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"1", @"2", @"3"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [SetCard maxRank]) {
        _rank = rank;
    }
}



@end
