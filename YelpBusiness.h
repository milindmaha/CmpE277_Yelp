//
//  YelpBusiness.h
//  CmpE277_Yelp
//
//  Created by Milind on 5/22/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface YelpBusiness : NSManagedObject


@property (nullable, nonatomic, retain) NSString *businessId;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *rating;
@property (nullable, nonatomic, retain) NSString *reviews;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSString *latitude;
@property (nullable, nonatomic, retain) NSString *longitude;
@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSString *ratingUrl;
@property (nullable, nonatomic, retain) NSString *snippetUrl;
@property (nullable, nonatomic, retain) NSString *snippetText;


@end