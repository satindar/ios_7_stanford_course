//
//  Card.h
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/15/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//
//  Abstract class

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (strong, nonatomic) NSDictionary *cardAttributes;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards; // abstract

@end
