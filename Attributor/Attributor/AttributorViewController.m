//
//  AttributorViewController.m
//  Attributor
//
//  Created by SATINDAR S DHILLON on 5/16/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "AttributorViewController.h"

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;
@end

@implementation AttributorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSMutableAttributedString *title =
        [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    
    [title setAttributes:@{ NSStrokeWidthAttributeName : @3 ,
                            NSStrokeColorAttributeName : self.outlineButton.tintColor }
                   range:NSMakeRange(0, [title length])];
    
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender
{
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
}
- (IBAction)outlineBodySelection
{
    [self.body.textStorage addAttributes:@{ NSStrokeWidthAttributeName : @-3 ,
                                            NSStrokeColorAttributeName : [UIColor blackColor]}
                                   range:self.body.selectedRange];
}

- (IBAction)unoutlineBodySelection
{
    [self.body.textStorage removeAttribute:NSStrokeColorAttributeName
                                     range:self.body.selectedRange];
}

@end
