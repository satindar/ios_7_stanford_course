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
@property (weak, nonatomic) IBOutlet UIView *gridView;
@property (weak, nonatomic) IBOutlet UIButton *addThreeCardsButton;

@end

@implementation CardGameViewController


- (CardMatchingGame *)game 
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.initialCardCount
                                                          usingDeck:[self createDeck]
                                          cardsToMatchInCurrentMode:self.numberOfCardsToMatch];
    return _game;
}

- (Grid *)grid
{
    if (!_grid) {
        _grid = [[Grid alloc] init];
        _grid.size = self.gridView.frame.size;
        _grid.cellAspectRatio = self.maxCardSize.width /self.maxCardSize.height;
        _grid.minimumNumberOfCells = self.maxCardsOnGrid;
    }
    
    return _grid;
}

- (Deck *)createDeck // abstract
{
    return nil;
}

- (UIView *)createCardViewUsingCard:(Card *)card // abstract
{
    return nil;
}

- (void)updateChosenProperty:(BOOL)cardIsChosen forCardView:(UIView *)cardView
{
    // abstract method. subclass may implement
}

- (void)updateUI
{
    for (int cardIndex = 0; cardIndex < [self.game numberOfCardsDealt]; cardIndex++) {
        Card *card = [self.game cardAtIndex:cardIndex];
        UIView *cardView = [self.gridView viewWithTag:(cardIndex + 1)];
        
        
        if (!cardView && !card.isMatched) {
            cardView = [self createCardViewUsingCard:card];
            cardView.tag = cardIndex + 1;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(touchCard:)];
            [cardView addGestureRecognizer:tap];
            cardView.frame = [self frameForFirstAvailableSpotInGrid:self.grid];
            [self.gridView addSubview:cardView];
        } else {
            if (card.isMatched) {
                [self removeViewWithAnimation:cardView];
            } else {
                [self updateChosenProperty:card.isChosen forCardView:cardView];
            }
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    if ([[self.gridView subviews] count] > self.maxNumberOfCardsOnScreen - 2) {
        self.addThreeCardsButton.enabled = NO;
    } else {
        self.addThreeCardsButton.enabled = YES;
    }
    
}

- (void)removeViewWithAnimation:(UIView *)view
{
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{ view.alpha = 0.0; }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [view removeFromSuperview];
                         }
                     }
     ];
}


- (CGRect)frameForFirstAvailableSpotInGrid:(Grid *)grid
{
    CGRect frame;
    for (int row = 0; row < grid.rowCount; row++) {
        for (int column = 0; column < grid.columnCount; column++) {
            CGPoint centerPointOfFrame = [grid centerOfCellAtRow:row inColumn:column];
            if (![self pointContainsCardSubview:centerPointOfFrame]) {
                frame = [self.grid frameOfCellAtRow:row inColumn:column];
                frame = CGRectInset(frame, frame.size.width * 0.1, frame.size.height * 0.1); // something is fishy here hmmmm...
                return frame;
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

- (IBAction)addThreeCardsToPlay:(UIButton *)sender
{
    [self.game addCardsIntoPlay:3];
    [self updateUI];
}

- (void)newGame
{
    self.game = nil;
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         for (UIView *cardView in [self.gridView subviews]) {
                             cardView.alpha = 0.0;
                         }
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [[self.gridView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                             [self updateUI];
                         }
                     }
     ];
}




- (void)touchCard:(UITapGestureRecognizer *)gesture
{
    [self.game chooseCardAtIndex:(gesture.view.tag - 1)];
    [self updateUI];
}

@end
