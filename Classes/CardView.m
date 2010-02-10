// -*- mode:objc; tab-width:4; indent-tabs-mode:t; -*-
//	CardView.m
//	SetGame
//
//	Created by Tristan King on 28/07/08.
//	Copyright 2008 Information Technology & Resources. All rights reserved.
//

#import "Card.h"
#import "CardView.h"

@implementation CardView

@synthesize touched;
@synthesize card;

- (id)initWithFrame:(CGRect)frame card:(Card*)card {
	if (self = [super initWithFrame:frame]) {
	  // Initialization code
	  [self setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
	  [self setCard:card];
	  touched = false;
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	if (card == nil) {
	} else {
	  CGSize size = [self bounds].size;
	  CGRect rrect = CGRectMake(0, 0, size.width, size.height);
	  CGFloat radius = 10.0;
	  
	  CGContextRef context = UIGraphicsGetCurrentContext();
	  
	  CGContextStrokePath(context);
	  
	  if (touched) {
		CGContextSetLineWidth(context, 5.0);
		CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
		CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
	  } else {
		CGContextSetLineWidth(context, 1.0);
		CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
		CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
	  }
	  
	  CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	  CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
	  
	  // Start at 1
	  CGContextMoveToPoint(context, minx, midy);
	  // Add an arc through 2 to 3
	  CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	  // Add an arc through 4 to 5
	  CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	  // Add an arc through 6 to 7
	  CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	  // Add an arc through 8 to 9
	  CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	  // Close the path
	  CGContextClosePath(context);
	  
	  CGContextDrawPath(context, kCGPathFillStroke);
	  
	  [self drawCard:card inContext:context];
	}
}

- (void)drawCard:(Card*)card inContext:context {
	CGSize size = [self bounds].size;
  
	CGFloat padding = 5.0;
	CGFloat symbol_width = 24.0;
	CGFloat symbol_height = 50.0;
	CGFloat total_width = (symbol_width * ([card number]+1)) + (padding * [card number]);
	CGFloat x_point = (size.width / 2.0) - (total_width / 2.0);
	CGFloat y_point = (size.height / 2.0) - (symbol_height / 2.0);
	
	UIColor *col;
	if ([card colour] == 0) {
	  col = [UIColor redColor];
	} else if ([card colour] == 1) {
	  col = [UIColor colorWithRed:0.68 green:0.0 blue:0.91 alpha:1.0];
	} else {
	  col = [UIColor colorWithRed:0.28 green:0.67 blue:0.29 alpha:1.0];
	}
	
	CGContextSetStrokeColorWithColor(context, [col CGColor]);
	
	CGContextSetFillColorWithColor(context, [col CGColor]);
	CGContextSetLineWidth(context, 2.5);
	
	for (unsigned i = 0; i < [card number]+1; i++) {
	  for (unsigned j = 0; j < 2; j++) {
		// a two pass draw is implemented for the case
		// where striped fill has to be drawn
		if (j == 0 || [card fill] == 1) {
		  if ([card symbol] == 0) {
			[self drawDiamondFromX:x_point Y:y_point symbol_width:symbol_width symbol_height:symbol_height inContext:context];
		  } else if ([card symbol] == 1) {
			[self drawOvalFromX:x_point Y:y_point symbol_width:symbol_width symbol_height:symbol_height inContext:context];
		  } else {
			[self drawSquiggleFromX:x_point Y:y_point symbol_width:symbol_width symbol_height:symbol_height inContext:context];
		  }
		}
		if (j == 0) {
		  if ([card fill] == 2) {
			CGContextDrawPath(context, kCGPathFillStroke);
		  } else {
			CGContextDrawPath(context, kCGPathStroke);
		  }
		} else {
		  x_point += (symbol_width + padding);
		  if ([card fill] == 1) {
			CGContextSaveGState(context);
			CGContextClip(context);
			// striped
			CGContextSetLineWidth(context, 2.0);
			unsigned stripes = 10;
			CGFloat dist = (symbol_height / (stripes + 1));
			CGFloat y = y_point;// - (symbol_height / 2.0);
			for (unsigned i = 0; i < stripes; i++) {
			  y += dist;
			  CGContextMoveToPoint(context, x_point, y);
			  CGContextAddLineToPoint(context, x_point - (symbol_width + padding), y);
			  CGContextStrokePath(context);
			}
			CGContextRestoreGState(context);
		  }
		}
	  }
	}
}

- (void)drawDiamondFromX:(CGFloat)x_point Y:(CGFloat)y_point symbol_width:(CGFloat)symbol_width symbol_height:(CGFloat)symbol_height inContext:(CGContextRef)context {
	CGFloat y = y_point + (symbol_height / 2.0);
	CGFloat x = x_point;
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, x, y);
	x += (symbol_width / 2.0);
	y += (symbol_height / 2.0);
	CGContextAddLineToPoint(context, x, y);
	x += (symbol_width / 2.0);
	y -= (symbol_height / 2.0);
	CGContextAddLineToPoint(context, x, y);
	x -= (symbol_width / 2.0);
	y -= (symbol_height / 2.0);
	CGContextAddLineToPoint(context, x, y);
	//x_point -= (symbol_width / 2.0);
	//y_point += (symbol_height / 2.0);
	//CGContextAddLineToPoint(context, x_point, y_point);
	CGContextClosePath(context);
}

- (void)drawOvalFromX:(CGFloat)x_point Y:(CGFloat)y_point symbol_width:(CGFloat)symbol_width symbol_height:(CGFloat)symbol_height inContext:(CGContextRef)context {
	CGRect rrect = CGRectMake(x_point, y_point, symbol_width, symbol_height);
	CGFloat radius = (symbol_width / 2.0);
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
	
	CGContextBeginPath(context);
	
	// Start at 1
	CGContextMoveToPoint(context, minx, midy);
	// Add an arc through 2 to 3
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	// Add an arc through 4 to 5
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	// Add an arc through 6 to 7
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	// Add an arc through 8 to 9
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	//CGContextMoveToPoint(context, x_point, y_point);
	CGContextClosePath(context);
}

- (void)drawSquiggleFromX:(CGFloat)x_point Y:(CGFloat)y_point symbol_width:(CGFloat)symbol_width symbol_height:(CGFloat)symbol_height inContext:(CGContextRef)context {
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, x_point+0.52, y_point+7.87);
	CGContextAddCurveToPoint(context, 
							 x_point+2.82, y_point+11.45,
							 x_point+5.38, y_point+15.51,
							 x_point+4.66, y_point+19.97);
	CGContextAddCurveToPoint(context, 
							 x_point+3.03, y_point+25.16,
							 x_point+0.64, y_point+30.44,
							 x_point+1.34, y_point+36.02);
	CGContextAddCurveToPoint(context, 
							 x_point+1.93, y_point+44.69,
							 x_point+11.11, y_point+51.60,
							 x_point+19.60, y_point+49.63);
	CGContextAddCurveToPoint(context, 
							 x_point+22.80, y_point+49.65,
							 x_point+25.02, y_point+45.67,
							 x_point+23.41, y_point+42.93);
	CGContextAddCurveToPoint(context, 
							 x_point+19.57, y_point+38.71,
							 x_point+17.90, y_point+32.32,
							 x_point+20.14, y_point+26.93);
	CGContextAddCurveToPoint(context, 
							 x_point+22.68, y_point+21.56,
							 x_point+24.96, y_point+15.42,
							 x_point+23.27, y_point+9.46);
	CGContextAddCurveToPoint(context, 
							 x_point+20.85, y_point+2.17,
							 x_point+12.00, y_point+-1.47,
							 x_point+4.88, y_point+0.62);
	CGContextAddCurveToPoint(context, 
							 x_point+1.50, y_point+0.90,
							 x_point+-1.00, y_point+4.73,
							 x_point+0.52, y_point+7.87);
	CGContextClosePath(context);
}


- (void)dealloc {
  [super dealloc];
}


@end
