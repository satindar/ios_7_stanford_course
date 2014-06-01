//
//  PlayingCardView.h
//


#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) BOOL isMatched;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end