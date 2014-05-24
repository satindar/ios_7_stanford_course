//
//  SetCardView.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/23/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#pragma mark - Properties

- (void)setSymbol:(NSString *)symbol
{
    if (_symbol != symbol) {
        _symbol = symbol;
        [self setNeedsDisplay];
    }
}

- (void)setShading:(NSString *)shading
{
    if (_shading != shading) {
        _shading = shading;
        [self setNeedsDisplay];
    }
}

- (void)setColor:(NSString *)color
{
    if (_color != color) {
        _color = color;
        [self setNeedsDisplay];
    }
}

- (void)setNumberOfSymbolsToDisplay:(NSUInteger)numberOfSymbolsToDisplay
{
    if (_numberOfSymbolsToDisplay != numberOfSymbolsToDisplay) {
        _numberOfSymbolsToDisplay = numberOfSymbolsToDisplay;
        [self setNeedsDisplay];
    }
}

- (void)setIsChosen:(BOOL)isChosen
{
    if (_isChosen != isChosen) {
        _isChosen = isChosen;
        [self setNeedsDisplay];
    }
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect =[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip]; // never draw outside the rounded rect
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    [self drawSymbolsWithAttributes];
}

- (void)drawSymbolsWithAttributes
{
    NSLog(@"%@", self.symbol);
    UIImage *cardImage;
    if ([self.symbol isEqualToString:@"triangle"]) {
        cardImage = [self triangleImage];
    } else if ([self.symbol isEqualToString:@"square"]) {
//        cardImage = [self circleImage];
    } else if ([self.symbol isEqualToString:@"circle"]) {
//        cardImage = [self squareImage];
    }
    CGRect imageRect = CGRectInset(self.bounds,
                                   self.bounds.size.width * 0.9,
                                   self.bounds.size.height * 0.9);
    [cardImage drawInRect:self.bounds];
    
}

- (UIImage *)triangleImage
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(650, 200), NO, 1.0);
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    int xPosition = 10;
    for (int i = 0; i < self.numberOfSymbolsToDisplay; i++) {
        [trianglePath moveToPoint:CGPointMake(xPosition, 150)];
        [trianglePath addLineToPoint:CGPointMake(xPosition + 150, 150)];
        [trianglePath addLineToPoint:CGPointMake(xPosition + 65, 10)];
        [trianglePath closePath];
        xPosition += 200;
       
        [self strokeAndFillShape:trianglePath];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)strokeAndFillShape:(UIBezierPath *)shape
{
    UIColor *color = [UIColor purpleColor]; // use case statement here for different
    [color setFill];
    [[UIColor blackColor] setStroke];
    [shape fill];
    [shape stroke];
    //do other stuff here
}




#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib // called when coming out of storyboard
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}



@end
