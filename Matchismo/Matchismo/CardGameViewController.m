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

@interface CardGameViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) Grid *grid;
@property (weak, nonatomic) IBOutlet UIView *gridView;
@property (weak, nonatomic) IBOutlet UIButton *addThreeCardsButton;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (strong, nonatomic) NSMutableArray *centerPointOfViews;
@property (nonatomic) NSInteger quantityOfCardsOnScreen;

@end

@implementation CardGameViewController

- (NSMutableArray *)cardViews
{
    if (!_cardViews) _cardViews = [[NSMutableArray alloc] init];
    return _cardViews;
}

- (NSMutableArray *)centerPointOfViews
{
    if (!_centerPointOfViews) _centerPointOfViews = [[NSMutableArray alloc] init];
    return _centerPointOfViews;
}

- (NSInteger)quantityOfCardsOnScreen
{
    if (!_quantityOfCardsOnScreen) _quantityOfCardsOnScreen = 0;
    return _quantityOfCardsOnScreen;
}

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gridView];
        _animator.delegate = self;
    }
    
    return _animator;
}

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

- (void)updateChosenProperty:(BOOL)cardIsChosen andMatchedProperty:(BOOL)cardIsMatched forCardView:(UIView *)cardView
{
    // abstract method. subclass may implement
}

- (void)updateUI
{
    for (int cardIndex = 0; cardIndex < [self.game numberOfCardsDealt]; cardIndex++) {
        Card *card = [self.game cardAtIndex:cardIndex];
        UIView *cardView;
        if ([self.cardViews count] > cardIndex) cardView = self.cardViews[cardIndex];
        
        
        if (!cardView && !card.isMatched) {
            cardView = [self createCardViewUsingCard:card];
            [self.cardViews addObject:cardView];
            self.quantityOfCardsOnScreen++;

            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(touchCard:)];
            [cardView addGestureRecognizer:tap];
            cardView.frame = [self frameForFirstAvailableSpotInGrid:self.grid];
            [self addViewWithAnimation:cardView];
            [self.centerPointOfViews addObject:[NSValue valueWithCGPoint:cardView.center]];
        } else {
            if (card.isMatched) {
                [self updateChosenProperty:card.isChosen andMatchedProperty:card.isMatched forCardView:cardView];
                [self removeViewWithAnimation:cardView];
                self.quantityOfCardsOnScreen--;
            } else {
                [self updateChosenProperty:card.isChosen andMatchedProperty:card.isMatched forCardView:cardView];
            }
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    if (self.quantityOfCardsOnScreen > self.maxNumberOfCardsOnScreen - 2 || [self.game deckIsEmpty]) {
        self.addThreeCardsButton.hidden = YES;
    } else {
        self.addThreeCardsButton.hidden = NO;
    }
    
}

- (void)addViewWithAnimation:(UIView *)view
{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.gridView addSubview:view];
                         view.alpha = 0.0;
                         view.alpha = 1.0;
                     }
                     completion:nil
     ];
}

- (void)removeViewWithAnimation:(UIView *)view
{
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         view.alpha = 0.0;
                     }
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIPinchGestureRecognizer *pinch =
        [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(stackCards:)];
    [self.gridView addGestureRecognizer:pinch];
}

- (IBAction)startNewGame:(UIButton *)sender
{
    [self newGame];
}

- (IBAction)addThreeCardsToPlay:(UIButton *)sender
{
    [self.game addCardsIntoPlay:3];
    self.animator = nil;
    [self updateUI];
}

- (void)newGame
{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         for (UIView *cardView in self.cardViews) {
                             cardView.alpha = 0.0;
                         }
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self.cardViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                             self.cardViews = nil;
                             self.game = nil;
                             self.quantityOfCardsOnScreen = 0;
                             self.animator = nil;
                             [self updateUI];
                         }
                     }
     ];
}

- (void)stackCards:(UIPinchGestureRecognizer *)gesture
{
    [UIView animateWithDuration:1.5
                          delay:0.0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         
                         for (UIView *cardView in self.cardViews) {
                             cardView.center = self.gridView.center;
                             UITapGestureRecognizer *tapStack = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                        action:@selector(tapStackOfCards:)];
                             
                             [cardView addGestureRecognizer:tapStack];

                         }
                     }
                     completion:^(BOOL finished) {
                         //
                     }
     ];
    
}


- (void)touchCard:(UITapGestureRecognizer *)gesture
{
    [self.game chooseCardAtIndex:[self.cardViews indexOfObject:gesture.view]];
    [self updateUI];
}

- (void)tapStackOfCards:(UITapGestureRecognizer *)gesture
{
    [UIView animateWithDuration:1.5
                          delay:0.0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         for (UIView *cardView in self.cardViews) {
                             int cardIndex = [self.cardViews indexOfObject:cardView];
                             UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(touchCard:)];
                             
                             [cardView addGestureRecognizer:tap];
                             CGPoint center = [self.centerPointOfViews[cardIndex] CGPointValue];
                             cardView.center = center;
                         }
                     }
                     completion:^(BOOL finished) {
                         self.animator = nil;
                     }
     ];
}

@end
