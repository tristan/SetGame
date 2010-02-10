//
//  SetBoardView.h
//  SetGame
//
//  Created by Tristan King on 28/07/08.
//  Copyright 2008 Information Technology & Resources. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CardView;
@class Deck;

@interface SetBoardView : UIView {
	CardView *card01;
	CardView *card02;
	CardView *card03;
	CardView *card04;
	CardView *card05;
	CardView *card06;
	CardView *card07;
	CardView *card08;
	CardView *card09;
	CardView *card10;
	CardView *card11;
	CardView *card12;
	//IBOutlet UIButton *noSetButton;
	
	CardView *touchedCard;
	NSMutableArray *allCards;
	NSMutableArray *selectedCards;
	Deck *deck;
	int setsFound;

	IBOutlet UILabel *scoreLabel;
	IBOutlet UILabel *label;
	IBOutlet UIToolbar *toolbar;
}

@property (nonatomic, retain) CardView *card01;
@property (nonatomic, retain) CardView *card02;
@property (nonatomic, retain) CardView *card03;
@property (nonatomic, retain) CardView *card04;
@property (nonatomic, retain) CardView *card05;
@property (nonatomic, retain) CardView *card06;
@property (nonatomic, retain) CardView *card07;
@property (nonatomic, retain) CardView *card08;
@property (nonatomic, retain) CardView *card09;
@property (nonatomic, retain) CardView *card10;
@property (nonatomic, retain) CardView *card11;
@property (nonatomic, retain) CardView *card12;
@property (nonatomic, retain) Deck *deck;
@property (nonatomic, retain) NSMutableArray *selectedCards;
@property (nonatomic, retain) NSMutableArray *allCards;

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UILabel *scoreLabel;
@property (nonatomic, retain) UIToolbar *toolbar;
//@property (nonatomic, retain) UIButton *noSetButton;

- (void)setUpCards;
- (void)setPicked;

- (IBAction)noSet:(id)sender;

@end
