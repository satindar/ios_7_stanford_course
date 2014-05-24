//
//  PlayingCardView.h
//  SuperCard
//
//  Created by SATINDAR S DHILLON on 5/18/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

//- (void)pinch:(UIPinchGestureRecognizer *)gesture;


@end
