//
//  SetCardDeck.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/19/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "SetCardDeck.h"
#import "PlayingCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *symbol in [PlayingCard validSymbols]) {
            for (NSUInteger rank = 1; rank <= 3; rank++) {
                for (NSString *color in [PlayingCard validColors]) {
                    for (NSString *shading in [PlayingCard validShadings]) {
                        PlayingCard *card = [[PlayingCard alloc] init];
                        card.symbol = symbol;
                        card.rank = rank;
                        card.color = color;
                        card.shading = shading;
                        
                        [self addCard:card];
                    }
                }
                
            }
        }
    }
    
    return self;
}

@end
