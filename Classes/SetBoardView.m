// -*- mode:objc; tab-width:4; indent-tabs-mode:t; -*-
//
//  SetBoardView.m
//  SetGame
//
//  Created by Tristan King on 28/07/08.
//  Copyright 2008 Information Technology & Resources. All rights reserved.
//

#import "Card.h"
#import "Deck.h"
#import "SetBoardView.h"
#import "CardView.h"

@implementation SetBoardView

@synthesize card01;
@synthesize card02;
@synthesize card03;
@synthesize card04;
@synthesize card05;
@synthesize card06;
@synthesize card07;
@synthesize card08;
@synthesize card09;
@synthesize card10;
@synthesize card11;
@synthesize card12;
@synthesize deck;
@synthesize selectedCards;
@synthesize allCards;

@synthesize label;
@synthesize scoreLabel;
@synthesize toolbar;
//@synthesize noSetButton;


- (id)initWithCoder:(NSCoder*)coder {
	if (self = [super initWithCoder:coder]) {
		[self setUpCards];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self setUpCards];
	}
	return self;
}

- (CGRect)buildRectForCard:(unsigned)cardno {
	CGSize size = [self bounds].size;
	CGFloat padding = 10.0;
	unsigned no_of_cards_along_x = 3;
	unsigned no_of_cards_along_y = 4;
	CGFloat card_width = (size.width-(padding*(no_of_cards_along_x+1))) / no_of_cards_along_x;
	CGFloat card_height = 60.0;
	CGFloat base_y = 25.0;
	unsigned i = cardno % no_of_cards_along_x;
	unsigned j = (cardno / no_of_cards_along_x) % no_of_cards_along_y;
	CGFloat x = padding + (i*padding) + (i*card_width);
	CGFloat y = base_y + padding + (j*padding) + (j*card_height);
	return CGRectMake(x, y, card_width, card_height);
}
- (void)setUpCards {
	
	self.deck = [[Deck alloc] init];
	
	CardView *aCardView;
	aCardView = [[CardView alloc] initWithFrame:[self buildRectForCard:0] card:[deck getNextCard]];
	self.card01 = aCardView;
	[aCardView release];
	
	aCardView = [[CardView alloc] initWithFrame:[self buildRectForCard:1] card:[deck getNextCard]];
	self.card02 = aCardView;
	[aCardView release];

	aCardView = [[CardView alloc] initWithFrame:[self buildRectForCard:2] card:[deck getNextCard]];
	self.card03 = aCardView;
	[aCardView release];
	
	aCardView = [[CardView alloc] initWithFrame:[self buildRectForCard:3] card:[deck getNextCard]];
	self.card04 = aCardView;
	[aCardView release];
	
	aCardView = [[CardView alloc] initWithFrame:[self buildRectForCard:4] card:[deck getNextCard]];
	self.card05 = aCardView;
	[aCardView release];
	
	aCardView = [[CardView alloc] initWithFrame:[self buildRectForCard:5] card:[deck getNextCard]];
	self.card06 = aCardView;
	[aCardView release];
	
	aCardView = [[CardView alloc] initWithFrame:[self buildRectForCard:6] card:[deck getNextCard]];
	self.card07 = aCardView;
	[aCardView release];
	
	aCardView = [[CardView alloc] initWithFrame:[self buildRectForCard:7] card:[deck getNextCard]];
	self.card08 = aCardView;
	[aCardView release];
	
	aCardView = [[CardView alloc] initWithFrame:[self buildRectForCard:8] card:[deck getNextCard]];
	self.card09 = aCardView;
	[aCardView release];
	
	aCardView = [[CardView alloc] initWithFrame:[self buildRectForCard:9] card:[deck getNextCard]];
	self.card10 = aCardView;
	[aCardView release];
	
	aCardView = [[CardView alloc] initWithFrame:[self buildRectForCard:10] card:[deck getNextCard]];
	self.card11 = aCardView;
	[aCardView release];
	
	aCardView = [[CardView alloc] initWithFrame:[self buildRectForCard:11] card:[deck getNextCard]];
	self.card12 = aCardView;
	[aCardView release];
	
	[self addSubview:card01];
	[self addSubview:card02];
	[self addSubview:card03];
	[self addSubview:card04];
	[self addSubview:card05];
	[self addSubview:card06];
	[self addSubview:card07];
	[self addSubview:card08];
	[self addSubview:card09];
	[self addSubview:card10];
	[self addSubview:card11];
	[self addSubview:card12];
	
	self.allCards = [NSMutableArray arrayWithObjects:card01, card02,
									card03, card04, card05, card06,
									card07, card08, card09, card10,
									card11, card12, nil];
	
	self.selectedCards = [NSMutableArray array];
	//[anArray dealloc];
	touchedCard = nil;
	setsFound = 0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	// We only support single touches, so anyObject retrieves just that touch from touches
	UITouch *touch = [touches anyObject];
	
	if ([[touch view] isMemberOfClass:[CardView class]]) {
		CardView *card = (CardView*)[touch view];
		touchedCard = card;
		//[label setText:@"touched"];
	} else {
	  //[label setText:[NSString stringWithFormat:@"classname: %@", [[touch view] className], nil]];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	if ([[touch view] isMemberOfClass:[CardView class]]) {
		CardView *card = (CardView*)[touch view];
		if ([card isEqual:touchedCard]) {
			if (card.touched) {
				[selectedCards removeObject:card];
				[card setTouched:false];
			} else {
				[selectedCards addObject:card];
				[card setTouched:true];
				if ([selectedCards count] == 3) {
					//[label setText:[NSString stringWithFormat:@"SELECTED 3 CARDS", nil]];
					[self setPicked];
					return;
				}
			}
			[card setNeedsDisplay];
			Card *c = [card card];
			//[label setText:[NSString stringWithFormat:@"colour:%d number:%d symbol:%d fill:%d", [c colour], [c number], [c symbol], [c fill], nil]];
		} else {
		}
	} else {
	}
	touchedCard = nil;
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	
	/*
     To impose as little impact on the device as possible, simply set the placard view's center and transformation to the original values.
     */
	touchedCard = nil;
}

- (void)updateScoreLabel {
  [scoreLabel setText:[NSString stringWithFormat:@"Score: %d Cards left in deck: %d", setsFound, [deck cardsLeft], nil]];
}

- (void)setPicked {
	CardView *card1 = [selectedCards objectAtIndex:0];
	CardView *card2 = [selectedCards objectAtIndex:1];
	CardView *card3 = [selectedCards objectAtIndex:2];
	if ([Deck checkForSet:[card1 card] card2:[card2 card] card3:[card3 card]]) {
	  [label setText:[NSString stringWithFormat:@"A SET", nil]];
	  setsFound += 1;
	  for (CardView *card in selectedCards) {
		Card *newc = [deck getNextCard];
		if (newc == nil) {
		  [label setText:@"OUT OF CARDS"];
		}
	    //[card setCard:[deck getNextCard]];
		[card setCard:newc];
	  }
	  [self updateScoreLabel];
	} else {
	  [label setText:[NSString stringWithFormat:@"NOT A SET", nil]];
	  setsFound -= 1;
	  [self updateScoreLabel];
	}
	for (unsigned i = 0; i < 3; i++) {
		CardView *c = [selectedCards objectAtIndex:i];
		[c setTouched:false];
		[c setNeedsDisplay];
	}
	[selectedCards removeAllObjects];
}

- (IBAction)noSet:(id)sender {
	[label setText:@"No Set!"];
	BOOL setFound = false;
	for (CardView *c1 in self.allCards) {
	  for (CardView *c2 in self.allCards) {
		for (CardView *c3 in self.allCards) {
		  setFound = setFound || [Deck checkForSet:[c1 card] card2:[c2 card] card3:[c3 card]];
		}
	  }
	}
	if (setFound) {
	  [label setText:@"WRONG!"];
	  setsFound -= 1;
	} else {
	  setsFound += 1;
	  if ([deck cardsLeft] < 1) {
		[label setText:@"GAME FINISHED"];
	  } else {
		for (CardView *c in self.allCards) {
		  [deck returnCard:[c card]];
		}
		for (CardView *c in self.allCards) {
		  [c setCard:[deck getNextCard]];
		  [c setTouched:false];
		  [c setNeedsDisplay];
		}
		[selectedCards removeAllObjects];
	  }
	}
	[self updateScoreLabel];
}

- (void)dealloc {
	[card01 dealloc];
	[card02 dealloc];
	[card03 dealloc];
	[card04 dealloc];
	[card05 dealloc];
	[card06 dealloc];
	[card07 dealloc];
	[card08 dealloc];
	[card09 dealloc];
	[card10 dealloc];
	[card11 dealloc];
	[card12 dealloc];
	[selectedCards dealloc];
	[touchedCard dealloc];
	[super dealloc];
}


@end
