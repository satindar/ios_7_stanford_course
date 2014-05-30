//
//  CardGameViewController.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/15/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Grid.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) Grid *grid;
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (weak, nonatomic) IBOutlet UIView *gridView;

@end

@implementation CardGameViewController



- (CardMatchingGame *)game // set numberOfPlayingCards property; and numberOfCardsToMatch
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.initialCardCount
                                                          usingDeck:[self createDeck]
                                          cardsToMatchInCurrentMode:self.numberOfCardsToMatch];
    return _game;
}

- (NSMutableArray *)cardViews
{
    if (!_cardViews) _cardViews = [[NSMutableArray alloc] initWithCapacity:self.initialCardCount];
    return _cardViews;
}


- (Grid *)grid
{
    if (!_grid) {
        _grid = [[Grid alloc] init];
        _grid.size = self.gridView.bounds.size;
        _grid.cellAspectRatio = self.maxCardSize.width /self.maxCardSize.height;
        _grid.minimumNumberOfCells = self.initialCardCount;
        _grid.maxCellWidth = self.maxCardSize.width;
    }
    
    return _grid;
}

- (Deck *)createDeck // abstract
{
    return nil;
}

- (UIView *)createCardViewUsingCard:(Card *)card
{
    return nil;
}



- (void)updateUI
{
    for (int cardIndex = 0; cardIndex < [self.game numberOfCardsDealt]; cardIndex++) {
        Card *card = [self.game cardAtIndex:cardIndex];
        // get or create the view associated with each card, if there is one
        UIView *cardView = [self.gridView viewWithTag:(cardIndex + 1)];
        
        
        if (!cardView) {
            cardView = [self createCardViewUsingCard:card];
            cardView.tag = cardIndex + 1;
            // add gesture recognizers?
            cardView.frame = [self frameForFirstAvailableSpotInGrid:self.grid];
            [self.gridView addSubview:cardView];
        }
    }
    
    
    
    
//    for (UIButton *cardButton in self.cardButtons) {
//        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
//        Card *card = [self.game cardAtIndex:cardButtonIndex];
//        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
//        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
//        cardButton.enabled = !card.isMatched;
//        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
//    }
    
    
}

- (CGRect)frameForFirstAvailableSpotInGrid:(Grid *)grid
{
    CGRect frame;
    for (int row = 0; row < grid.rowCount; row++) {
        for (int column = 0; column < grid.columnCount; column++) {
            CGPoint centerPointOfFrame = [grid centerOfCellAtRow:row inColumn:column];
            if (![self pointContainsCardSubview:centerPointOfFrame]) {
                frame = [self.grid frameOfCellAtRow:row inColumn:column];
            }
        }
    }
    return frame;
}

- (BOOL)pointContainsCardSubview:(CGPoint)point
{
    for(UIView *aView in [self.gridView subviews])
    {
        if(CGRectContainsPoint(aView.frame, point))
        {
            return YES;
        }
    }
    return NO;
}

- (IBAction)startNewGame:(UIButton *)sender
{
    [self newGame];
}

- (void)newGame
{
    self.game = nil;
    [self updateUI];
}





- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}



//- (IBAction)touchCardButton:(UIButton *)sender
//{
//    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
//    [self.game chooseCardAtIndex:chosenButtonIndex];
//    if (self.gameModeSegmentedControl) {
//        self.gameModeSegmentedControl.enabled = NO;
//    }
//    [self updateUI];
//}



@end
