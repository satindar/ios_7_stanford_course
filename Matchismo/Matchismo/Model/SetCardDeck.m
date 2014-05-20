//
//  SetCardDeck.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/19/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *symbol in [SetCard validSymbols]) {
            for (NSUInteger rank = 1; rank <= 3; rank++) {
                for (NSString *color in [SetCard validColors]) {
                    for (NSString *shading in [SetCard validShadings]) {
                        SetCard *card = [[SetCard alloc] init];
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
