//
//  CardView.h
//  SetGame
//
//  Created by Tristan King on 28/07/08.
//  Copyright 2008 Information Technology & Resources. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Card;

@interface CardView : UIView {
	BOOL touched;
	Card *card;
}

@property BOOL touched;
@property (nonatomic, retain) Card *card;

- (id)initWithFrame:(CGRect)frame card:(Card*)card;
//- (void)drawDiamondsWithColour:(UIColor*)colour number:(unsigned)number fill:(unsigned)fill inContext:(CGContextRef)context;
//- (void)drawOvalsWithColour:(UIColor*)colour number:(unsigned)number fill:(unsigned)fill inContext:(CGContextRef)context;
//- (void)drawSquigglesWithColour:(UIColor*)colour number:(unsigned)number fill:(unsigned)fill inContext:(CGContextRef)context;
- (void)drawCard:(Card*)card inContext:context;
- (void)drawDiamondFromX:(CGFloat)x_point Y:(CGFloat)y_point symbol_width:(CGFloat)symbol_width symbol_height:(CGFloat)symbol_height inContext:(CGContextRef)context;
- (void)drawOvalFromX:(CGFloat)x_point Y:(CGFloat)y_point symbol_width:(CGFloat)symbol_width symbol_height:(CGFloat)symbol_height inContext:(CGContextRef)context;
- (void)drawSquiggleFromX:(CGFloat)x_point Y:(CGFloat)y_point symbol_width:(CGFloat)symbol_width symbol_height:(CGFloat)symbol_height inContext:(CGContextRef)context;
@end
