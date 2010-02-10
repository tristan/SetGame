//
//  Card.h
//  SetGame
//
//  Created by Tristan King on 29/07/08.
//  Copyright 2008 Information Technology & Resources. All rights reserved.
//

@interface Card : NSObject {
	unsigned colour;
	unsigned number;
	unsigned symbol;
	unsigned fill;
}

@property unsigned colour;
@property unsigned number;
@property unsigned symbol;
@property unsigned fill;

- (id)initWithColour:(unsigned)colour number:(unsigned)number symbol:(unsigned)symbol fill:(unsigned)fill;

@end
