//
//  CardGameViewController.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/15/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]
                                          cardsToMatchInCurrentMode:[self numberOfCardsToMatch]];
    return _game;
}

- (Deck *)createDeck // abstract
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    if (self.gameModeSegmentedControl) {
        self.gameModeSegmentedControl.enabled = NO;
    }
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    [self updateLastMoveLabel];
    
}

- (void)updateLastMoveLabel
{
    self.lastMoveLabel.attributedText = [self descriptionOfLastMove];
    self.game.lastCardsPlayed = nil;
}

- (NSAttributedString *)descriptionOfLastMove
{
    NSString *lastMoveText = @"";
    int points = self.game.pointsLastScored;
    NSString *cardsPlayed = @"";
    NSMutableArray *cards = self.game.lastCardsPlayed;

    for (Card *card in cards) {
        if ([cardsPlayed length] == 0) {
            NSString *firstCardPlayed = [NSString stringWithFormat:@"%@", card.contents];
            cardsPlayed = [cardsPlayed stringByAppendingString:firstCardPlayed];
        } else {
            NSString *cardPlayed = [NSString stringWithFormat:@" & %@", card.contents];
            cardsPlayed = [cardsPlayed stringByAppendingString:cardPlayed];
        }
    }
    
    NSString *pointDescriptionText = @"points";
    if (points == 1 || points == -1) {
        pointDescriptionText = @"point";
    }
    
    if ([cards count] == self.game.cardsToMatchInCurrentGameMode) {
        if (points < 0) {
            points = points * -1;
            lastMoveText = [NSString stringWithFormat:@"%@ do not match! %d point penalty.", cardsPlayed, points];
        } else if (points > 0) {
            lastMoveText = [NSString stringWithFormat:@"Matched %@ for %d %@!", cardsPlayed, points, pointDescriptionText];
        } else {
            lastMoveText = [NSString stringWithFormat:@"No points earned for %@.", cardsPlayed];
        }
    } else if (points <= 0 && [cards count] > 0){
        points = points * -1;
        lastMoveText = [NSString stringWithFormat:@"%@", cardsPlayed];
    }
    
    return [[NSAttributedString alloc] initWithString:lastMoveText];
}


- (IBAction)gameMatchModeChanged:(UISegmentedControl *)sender
{
    self.game.cardsToMatchInCurrentGameMode = [self numberOfCardsToMatch];
}

- (int)numberOfCardsToMatch
{
    int numberOfCards = 0;
    if (self.gameModeSegmentedControl.selectedSegmentIndex == 0) {
        numberOfCards = 2;
    }
    if (self.gameModeSegmentedControl.selectedSegmentIndex == 1) {
        numberOfCards = 3;
    }
    return numberOfCards;
}

- (IBAction)startNewGame:(UIButton *)sender
{
    [self newGame];
}

- (void)newGame
{
    self.game = nil;
    if (self.gameModeSegmentedControl) {
        self.gameModeSegmentedControl.enabled = YES;
    }
    self.lastMoveLabel.text = @"";
    [self updateUI];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSString *title = card.isChosen ? card.contents : @"";
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title];
    return attributedTitle;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
