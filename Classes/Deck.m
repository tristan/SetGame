// -*- mode:objc; tab-width:4; indent-tabs-mode:t; -*-
//
//  Deck.m
//  SetGame
//
//  Created by Tristan King on 29/07/08.
//  Copyright 2008 Information Technology & Resources. All rights reserved.
//

#import "Card.h"
#import "Deck.h"
#import <stdlib.h>

@implementation Deck

#define RANDOM_SEED() srandom(time(NULL))
#define RANDOM_INT(__MIN__,__MAX__) ((__MIN__) + random() % ((__MAX__+1)-(__MIN__)))

@synthesize cards;

- (id)init {
	totalCards = 0;
	self.cards = [NSMutableArray array];
	for (int c = 0; c < 3; c++) {
		for (int n = 0; n < 3; n++) {
			for (int s = 0; s < 3; s++) {
				for (int f = 0; f < 3; f++) {
					Card *card = [[Card alloc] initWithColour:c number:n symbol:s fill:f];
					[cards addObject:card];
					totalCards += 1;
				}
			}
		}
	}
	RANDOM_SEED();
	return [super init];
}

- (unsigned)cardsLeft {
	return [cards count];
}

- (Card*)getNextCard {
	if ([cards count] < 1) {
	  return nil;
	}
	int index = RANDOM_INT(0, [cards count]-1);
	Card *card = [cards objectAtIndex:index];
	[cards removeObjectAtIndex:index];
	return card;
}

- (void)returnCard:(Card*)card {
	[cards addObject:card];
}

+ (BOOL)checkForSet:(Card*)card1 card2:(Card*)card2 card3:(Card*)card3 {
  if ((card1 == nil) || (card2 == nil) || (card3 == nil)) {
	return false;
  }
  if ((![card1 isEqual:card2]) && (![card1 isEqual:card3]) && (![card2 isEqual:card3])) {
	BOOL col_match = false;
	BOOL num_match = false;
	BOOL sym_match = false;
	BOOL fil_match = false;
	if ([card1 colour] != [card2 colour] && [card1 colour] != [card3 colour] && [card2 colour] != [card3 colour]) {
	  col_match = true;
	} else if ([card1 colour] == [card2 colour] && [card2 colour] == [card3 colour]) {
	  col_match = true;
	}
	if ([card1 number] != [card2 number] && [card1 number] != [card3 number] && [card2 number] != [card3 number]) {
	  num_match = true;
	} else if ([card1 number] == [card2 number] && [card2 number] == [card3 number]) {
	  num_match = true;
	}
	if ([card1 symbol] != [card2 symbol] && [card1 symbol] != [card3 symbol] && [card2 symbol] != [card3 symbol]) {
	  sym_match = true;
	} else if ([card1 symbol] == [card2 symbol] && [card2 symbol] == [card3 symbol]) {
	  sym_match = true;
	}
	if ([card1 fill] != [card2 fill] && [card1 fill] != [card3 fill] && [card2 fill] != [card3 fill]) {
	  fil_match = true;
	} else if ([card1 fill] == [card2 fill] && [card2 fill] == [card3 fill]) {
	  fil_match = true;
	}
	return (col_match && num_match && sym_match && fil_match);
  } else {
	return false;
  }
}

- (void)dealloc {
	[cards dealloc];
	[super dealloc];
}

@end
