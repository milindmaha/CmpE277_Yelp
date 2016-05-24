//
//  Annotation.m
//  CmpE277_Yelp
//
//  Created by Milind on 5/23/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

@synthesize coordinate = _coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {

	self = [super init];
	
	if (self) {
		
		_coordinate = coordinate;
	}
	
	return self;
}


@end