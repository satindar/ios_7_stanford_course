//
//  SetCardView.h
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/23/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (nonatomic) NSUInteger symbol;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger numberOfSymbolsToDisplay;

@property (nonatomic) BOOL isChosen;
@property (nonatomic) BOOL isMatched;

@end
