//
//  Deck.h
//  SetGame
//
//  Created by Tristan King on 29/07/08.
//  Copyright 2008 Information Technology & Resources. All rights reserved.
//

@class Card;

@interface Deck : NSObject {
	NSMutableArray *cards;
	unsigned totalCards;
}

@property (nonatomic, retain) NSMutableArray *cards;

//- (void)init;
- (Card*)getNextCard;
- (void)returnCard:(Card*)card;
- (unsigned)cardsLeft;
+ (BOOL)checkForSet:(Card*)card1 card2:(Card*)card2 card3:(Card*)card3;
//- (void)dealloc;

@end
