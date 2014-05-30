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

- (void)setSymbol:(NSUInteger)symbol
{
    if (_symbol != symbol) {
        _symbol = symbol;
        [self setNeedsDisplay];
    }
}

- (void)setShading:(NSUInteger)shading
{
    if (_shading != shading) {
        _shading = shading;
        [self setNeedsDisplay];
    }
}

- (void)setColor:(NSUInteger)color
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
    
    if (self.isChosen) {
        [[UIColor lightGrayColor] setFill];
    } else {
        [[UIColor whiteColor] setFill];
    }
    
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    [self drawSymbolsWithAttributes];
}

- (void)drawSymbolsWithAttributes
{
    UIImage *cardImage;
    if (self.symbol == 1) {
        cardImage = [self triangleImage];
    } else if (self.symbol == 2) {
        cardImage = [self circleImage];
    } else if (self.symbol == 3) {
        cardImage = [self squareImage];
    }
    
    float hfactor = cardImage.size.width / self.bounds.size.width;
    float vfactor = cardImage.size.height / self.bounds.size.height;
    
    float factor = fmax(hfactor, vfactor);
    
    // Divide the size by the greater of the vertical or horizontal shrinkage factor
    float newWidth = cardImage.size.width / factor;
    float newHeight = cardImage.size.height / factor;
    
    // Then figure out if you need to offset it to center vertically or horizontally
    float leftOffset = (self.bounds.size.width - newWidth) / 2;
    float topOffset = (self.bounds.size.height - newHeight) / 2;
    
    CGRect imageRect = CGRectMake(leftOffset, topOffset, newWidth, newHeight);

    [cardImage drawInRect:imageRect];
    
}

- (UIImage *)triangleImage
{
    int triangleWidth = 150;
    int kerning = 25;
    int xOffset = 10;
    int imageHeight = 200;
    int width = triangleWidth * self.numberOfSymbolsToDisplay + kerning * (self.numberOfSymbolsToDisplay - 1) + (xOffset * 2);
    UIGraphicsBeginImageContext(CGSizeMake(width, imageHeight));
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    int xPosition = xOffset;
    for (int i = 0; i < self.numberOfSymbolsToDisplay; i++) {
        [trianglePath moveToPoint:CGPointMake(xPosition, 150)];
        [trianglePath addLineToPoint:CGPointMake(xPosition + triangleWidth, 150)];
        [trianglePath addLineToPoint:CGPointMake(xPosition + (triangleWidth / 2), 10)];
        [trianglePath closePath];
        xPosition += triangleWidth + kerning;
       
        [self strokeAndFillShape:trianglePath];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)circleImage
{
    int circleRadius = 150;
    int kerning = 25;
    int xOffset = 10;
    int imageHeight = 200;
    int yOffset = (imageHeight - circleRadius) / 2;
    int width = circleRadius * self.numberOfSymbolsToDisplay + kerning * (self.numberOfSymbolsToDisplay - 1) + (xOffset * 2);
    
    UIGraphicsBeginImageContext(CGSizeMake(width, imageHeight));
    
    for (int i = 0; i < self.numberOfSymbolsToDisplay; i++) {
        CGRect imageRect = CGRectMake(xOffset, yOffset, circleRadius, circleRadius);
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:imageRect];
        xOffset += circleRadius + kerning;
        
        [self strokeAndFillShape:circlePath];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)squareImage
{
    int edgeLength = 100;
    int kerning = 25;
    int xOffset = 25;
    int imageHeight = 200;
    int yOffset = (imageHeight - edgeLength) / 2;
    int width = edgeLength * self.numberOfSymbolsToDisplay + kerning * (self.numberOfSymbolsToDisplay - 1) + (xOffset * 2);
    
    UIGraphicsBeginImageContext(CGSizeMake(width, imageHeight));
    
    for (int i = 0; i < self.numberOfSymbolsToDisplay; i++) {
        CGRect imageRect = CGRectMake(xOffset, yOffset, edgeLength, edgeLength);
        UIBezierPath *squarePath = [UIBezierPath bezierPathWithRect:imageRect];
        xOffset += edgeLength + kerning;
        
        [self strokeAndFillShape:squarePath];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)strokeAndFillShape:(UIBezierPath *)shape
{
    shape.lineWidth = 5;
    
    
    UIColor *color;
    if (self.color == 1) {
        color = [UIColor purpleColor];
    } else if (self.color == 2) {
        color = [UIColor redColor];
    } else if (self.color == 3) {
        color = [UIColor greenColor];
    }
    
    [color setFill];
    [color setStroke];
    
    if (self.shading == 1) {
        [shape fill];
    } else if (self.shading == 2) {
        shape.lineWidth = 5;
        [shape stroke];
    } else if (self.shading == 3) {
        UIImage *backgroundImage = [self createImageWithStripedBackground:shape withColor:color];
        [[UIColor colorWithPatternImage:backgroundImage] setFill];
        [shape fill];
        shape.lineWidth = 5;
        [shape stroke];
    }
    
}

- (UIImage *)createImageWithStripedBackground:(UIBezierPath *)shape withColor:(UIColor *)color
{
    UIGraphicsBeginImageContext(CGSizeMake(shape.bounds.size.width, shape.bounds.size.height));
    float stripeHeight = shape.bounds.size.height / 15.0;
    float stripeWidth = shape.bounds.size.width;
    float yOffset = 0.0;
    
    for (int i = 0; i < 15; i += 2) {
        UIBezierPath *stripe =
            [UIBezierPath bezierPathWithRect:CGRectMake(0, yOffset, stripeWidth, stripeHeight)];
        [color setFill];
        [stripe fill];
        yOffset += 2 * stripeHeight;
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
