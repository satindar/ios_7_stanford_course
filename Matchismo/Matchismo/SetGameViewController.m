//
//  SetGameViewController.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/19/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
#import "SetCard.h"

@interface SetGameViewController ()


@end

@implementation SetGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (UIView *)createCardViewUsingCard:(Card *)card
{
    SetCardView *cardView = [[SetCardView alloc] init];
    SetCard *setCard = (SetCard *)card;
    
    cardView.symbol = setCard.symbol;
    cardView.shading = setCard.shading;
    cardView.color = setCard.color;
    cardView.numberOfSymbolsToDisplay = setCard.rank;
    cardView.isChosen = setCard.isChosen;

    return cardView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.maxCardSize = CGSizeMake(60, 40);
    self.initialCardCount = 12;
    self.numberOfCardsToMatch = 3;
    [self newGame];
}

- (UIImage *)backgroundImageForCard:(Card *)card // move to view
{
    UIImage *cardBackground = [UIImage imageNamed:@"cardfront"];
    if (card.isChosen) {
        cardBackground = [SetGameViewController imageWithColor:[UIColor yellowColor]
                                                       andSize:cardBackground.size];
    }
    return cardBackground;
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size // move to view
{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


@end
