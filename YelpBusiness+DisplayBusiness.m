//
//  YelpBusiness+DisplayBusiness.m
//  CmpE277_Yelp
//
//  Created by Milind on 5/22/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import "YelpBusiness+DisplayBusiness.h"

@implementation YelpBusiness (DisplayBusiness)

+ (NSArray *)parseObjects:(NSArray *)buizObjects {

	NSMutableArray *array = [NSMutableArray array];
	
	for (id buiz in buizObjects) {
		
		if ([buiz isKindOfClass:[YelpBusiness class]]) {
			
			[array addObject:[self getFromYelpBusiness:buiz]];
		} else {
			
			[array addObject:[self getFromDictionary:buiz]];
		}
	}
	
	return array;
}


+ (NSDictionary *)getFromYelpBusiness:(YelpBusiness *)buiz {
	
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

	[dictionary setObject:buiz.businessId forKey:@"businessId"];
	[dictionary setObject:buiz.name forKey:@"name"];
	[dictionary setObject:buiz.rating forKey:@"rating"];
	[dictionary setObject:buiz.reviews forKey:@"reviews"];
	[dictionary setObject:buiz.address forKey:@"address"];
	[dictionary setObject:buiz.phoneNumber forKey:@"phoneNumber"];
	[dictionary setObject:buiz.latitude forKey:@"latitude"];
	[dictionary setObject:buiz.longitude forKey:@"longitude"];
	[dictionary setObject:buiz.imageUrl forKey:@"imageUrl"];
	[dictionary setObject:buiz.ratingUrl forKey:@"ratingUrl"];
	[dictionary setObject:buiz.snippetUrl forKey:@"snippetUrl"];
	[dictionary setObject:buiz.snippetText forKey:@"snippetText"];

	return dictionary;
}

+ (NSDictionary *)getFromDictionary:(NSDictionary *)buizInfo {
	
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	
	NSString *buizId = [buizInfo objectForKey:@"id"];
	if (!buizId) {
		
		buizId = [buizInfo objectForKey:@"businessId"];
	}
	if (buizId) {
		
		[dictionary setObject:buizId forKey:@"businessId"];
	}
	
	NSString *buizName = [buizInfo objectForKey:@"name"];
	if (buizName) {
		
		[dictionary setObject:buizName forKey:@"name"];
	}
	
	NSString *buizRating = [NSString stringWithFormat:@"%@", [buizInfo objectForKey:@"rating"]];
	if (buizRating) {
		
		[dictionary setObject:buizRating forKey:@"rating"];
	}
	
	NSString *buizReviews = [NSString stringWithFormat:@"%d", [buizInfo objectForKey:@"review_count"]];
	if (buizReviews) {
		
		[dictionary setObject:buizReviews forKey:@"reviews"];
	}
	
	NSString *buizContact = [buizInfo objectForKey:@"display_phone"];
	if (buizContact) {
		
		[dictionary setObject:buizContact forKey:@"phoneNumber"];
	}
	
	NSString *buizImageUrl = [buizInfo objectForKey:@"image_url"];
	if (buizImageUrl) {
		
		[dictionary setObject:buizImageUrl forKey:@"imageUrl"];
	}
	
	NSString *buizRatingUrl = [buizInfo objectForKey:@"rating_img_url"];
	if (buizRatingUrl) {
		
		[dictionary setObject:buizRatingUrl forKey:@"ratingUrl"];
	}

	NSString *buizSnippetUrl = [buizInfo objectForKey:@"snippet_image_url"];
	if (buizSnippetUrl) {
		
		[dictionary setObject:buizSnippetUrl forKey:@"snippetUrl"];
	}

	NSString *buizSnippetText = [buizInfo objectForKey:@"snippet_text"];
	if (buizSnippetText) {
		
		[dictionary setObject:buizSnippetText forKey:@"snippetText"];
	}
	
	NSDictionary *addressInfo = [buizInfo objectForKey:@"location"];
	NSString *buizAddress = [NSString stringWithFormat:@"%@", [[addressInfo objectForKey:@"display_address"] componentsJoinedByString:@", "]];
	if (buizAddress) {
		
		[dictionary setObject:buizAddress forKey:@"address"];
	}
	
	NSDictionary *geoLocation = [addressInfo objectForKey:@"coordinate"];
	NSString *buizLatitude = [NSString stringWithFormat:@"%@", [geoLocation objectForKey:@"latitude"]];
	if (buizLatitude) {
		
		[dictionary setObject:buizLatitude forKey:@"latitude"];
	}
	
	NSString *buizLongitude = [NSString stringWithFormat:@"%@", [geoLocation objectForKey:@"longitude"]];
	if (buizLongitude) {
		
		[dictionary setObject:buizLongitude forKey:@"longitude"];
	}

	return dictionary;
}


@end