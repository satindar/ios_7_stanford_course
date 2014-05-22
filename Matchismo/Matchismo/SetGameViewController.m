//
//  SetGameViewController.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/19/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"

@interface SetGameViewController ()


@end

@implementation SetGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self newGame];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    UIImage *cardBackground = [UIImage imageNamed:@"cardfront"];
    if (card.isChosen) {
        cardBackground = [SetGameViewController imageWithColor:[UIColor yellowColor]
                                                       andSize:cardBackground.size];
    }
    return cardBackground;
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
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

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSString *symbolString = @"";
    for (int i = 0; i < [card.cardAttributes[@"rank"] intValue]; i++) {
        symbolString = [symbolString stringByAppendingString:card.cardAttributes[@"symbol"]];
    }
    NSMutableAttributedString *cardTitle = [[NSMutableAttributedString alloc] initWithString:symbolString];
    [self setColorAttribute:cardTitle withColor:card.cardAttributes[@"color"]];
    [self setShadingAttribute:cardTitle withShading:card.cardAttributes[@"shading"]];
    
    return cardTitle;
}

- (void)setColorAttribute:(NSMutableAttributedString *)cardTitle
                                       withColor:(NSString *)color
{
    UIColor *textColor = [UIColor blackColor];
    if ([color isEqualToString:@"red"]) {
        textColor = [UIColor redColor];
    } else if ([color isEqualToString:@"green"]) {
        textColor = [UIColor greenColor];
    } else if ([color isEqualToString:@"purple"]) {
        textColor = [UIColor purpleColor];
    }
    
    [cardTitle addAttributes:@{ NSForegroundColorAttributeName : textColor }
                       range:NSMakeRange(0, [cardTitle length])];
}

- (void)setShadingAttribute:(NSMutableAttributedString *)cardTitle
                                       withShading:(NSString *)shading
{
    int underlineStyle;
    if ([shading isEqualToString:@"open"]) {
        underlineStyle = 0;
    } else if ([shading isEqualToString:@"solid"]) {
        underlineStyle = 1;
    } else if ([shading isEqualToString:@"outlined"]) {
        underlineStyle = 4;
    }
    [cardTitle addAttributes:@{ NSStrikethroughStyleAttributeName : [NSNumber numberWithInt:underlineStyle] }
                       range:NSMakeRange(0, [cardTitle length])];
}

- (NSAttributedString *)descriptionOfLastMove
{
    NSMutableAttributedString *lastMoveText = [[NSMutableAttributedString alloc] initWithString:@"Hello and Welcome to Set!"];
    int points = self.game.pointsLastScored;
    NSMutableAttributedString *cardsPlayed = [[NSMutableAttributedString alloc] init];
    NSMutableArray *cards = self.game.lastCardsPlayed;
    
    for (Card *card in cards) {
        if ([cardsPlayed length] == 0) {
            [cardsPlayed appendAttributedString:[self titleForCard:card]];
        } else {
            [cardsPlayed appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" & "]];
            [cardsPlayed appendAttributedString:[self titleForCard:card]];
        }
    }
    
    NSString *pointDescriptionText = @"points";
    if (points == 1 || points == -1) {
        pointDescriptionText = @"points";
    }
    
    if ([cards count] == self.game.cardsToMatchInCurrentGameMode) {
        if (points < 0) {
            points = points * -1;
            NSString *textToAppend = [NSString stringWithFormat:@" do not form a set! %d point penalty.", points];
            [cardsPlayed appendAttributedString:[[NSMutableAttributedString alloc] initWithString:textToAppend]];
        } else if (points > 0) {
            NSString *textToAppend = [NSString stringWithFormat:@" form a set! you earned %d %@!", points, pointDescriptionText];
            [cardsPlayed appendAttributedString:[[NSMutableAttributedString alloc] initWithString:textToAppend]];
        } else {
            NSString *textToAppend = [NSString stringWithFormat:@". No points earned."];
            [cardsPlayed appendAttributedString:[[NSMutableAttributedString alloc] initWithString:textToAppend]];
        }
    } else if (points <= 0 && [cards count] > 0){
        points = points * -1;
        lastMoveText = cardsPlayed;
    }
    
    return cardsPlayed;
}


- (int)numberOfCardsToMatch
{
    return 3;
}


@end
