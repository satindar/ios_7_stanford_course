//
//  SetCard.h
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/20/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger symbol;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger rank;

- (NSDictionary *)cardAttributes;

@end
