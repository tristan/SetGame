//
//  Card.m
//  SetGame
//
//  Created by Tristan King on 29/07/08.
//  Copyright 2008 Information Technology & Resources. All rights reserved.
//

#import "Card.h"


@implementation Card

@synthesize colour;
@synthesize number;
@synthesize symbol;
@synthesize fill;

- (id)initWithColour:(unsigned)colour number:(unsigned)number symbol:(unsigned)symbol fill:(unsigned)fill {
	[self setColour:colour];
	[self setNumber:number];
	[self setSymbol:symbol];
	[self setFill:fill];
	return [self init];
}

@end
