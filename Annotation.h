//
//  Annotation.h
//  CmpE277_Yelp
//
//  Created by Milind on 5/23/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Annotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;


@end