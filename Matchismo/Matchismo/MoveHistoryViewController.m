//
//  MoveHistoryViewController.m
//  Matchismo
//
//  Created by SATINDAR S DHILLON on 5/21/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

#import "MoveHistoryViewController.h"

@interface MoveHistoryViewController ()
//@property (nonatomic, strong) NSArray *historyOfMoves;
@property (weak, nonatomic) IBOutlet UITextView *textField;

@end

@implementation MoveHistoryViewController


- (void)setHistoryOfMoves:(NSArray *)historyOfMoves
{
    _historyOfMoves = historyOfMoves;
    if (self.view.window) [self updateUI]; //give viewWillAppear a chance handle this
}

- (void)updateUI
{
    NSMutableAttributedString *textForTextField = [[NSMutableAttributedString alloc] init];
    for (NSAttributedString *moveDescription in self.historyOfMoves) {
        [textForTextField appendAttributedString:moveDescription];
        [textForTextField appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    self.textField.attributedText = textForTextField;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}


@end
