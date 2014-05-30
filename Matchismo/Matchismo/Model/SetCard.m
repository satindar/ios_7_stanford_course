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

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([self createsSetWithOtherCards:(NSArray *)otherCards]) {
        score = 1;
    }
    
    return score;
}

- (BOOL)createsSetWithOtherCards:(NSArray *)otherCards
{
    NSMutableArray *allCards = [[NSMutableArray alloc] initWithArray:otherCards];
    [allCards addObject:self];

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


+ (NSArray *)attributeStrings
{
    return @[@"?", @"1", @"2", @"3"];
}

+ (NSUInteger)maxRank
{
    return [[self attributeStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [SetCard maxRank]) {
        _rank = rank;
    }
}

- (void)setSymbol:(NSUInteger)symbol
{
    if (symbol <= [SetCard maxRank]) {
        _symbol = symbol;
    }
}

- (void)setShading:(NSUInteger)shading
{
    if (shading <= [SetCard maxRank]) {
        _shading = shading;
    }
}

- (void)setColor:(NSUInteger)color
{
    if (color <= [SetCard maxRank]) {
        _color = color;
    }
}

- (NSDictionary *)cardAttributes
{
    return @{@"symbol": [SetCard attributeStrings][self.symbol],
             @"rank": [SetCard attributeStrings][self.rank],
             @"shading": [SetCard attributeStrings][self.shading],
             @"color": [SetCard attributeStrings][self.color] };
}

@end
