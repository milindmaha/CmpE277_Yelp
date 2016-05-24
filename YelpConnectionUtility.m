//
//  YelpConnectionUtility.m
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import "YelpConnectionUtility.h"
#import "NSURLRequest+OAuth.h"

static NSString * const kAPIHost           = @"api.yelp.com";
static NSString * const kSearchPath        = @"/v2/search/";
static NSString * const kBusinessPath      = @"/v2/business/";
static NSString * const kSearchLimit       = @"20";


@implementation YelpConnectionUtility


+ (void)getBusinessInfoFor:(NSString *)search inLocation:(NSString *)location withSortFilter:(int)sortFilter onCompletion:(void (^)(NSArray *jsonResponse, NSError *error))onCompletion {
	
	NSLog(@"Querying the Search API with term \'%@\' and location \'%@'", search, location);

	NSURLRequest *searchRequest = [self _searchRequestWithTerm:search location:location sortFilter:sortFilter];
	NSURLSession *session = [NSURLSession sharedSession];
	[[session dataTaskWithRequest:searchRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
		
		if (!error && httpResponse.statusCode == 200) {
			
			NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
			NSArray *businessArray = searchResponseJSON[@"businesses"];
			
			if ([businessArray count] != 0) {
				
				onCompletion(businessArray, nil);
			} else {
				
				onCompletion(nil, error);
			}
		} else {
			
			onCompletion(nil, error);
		}
	}] resume];
}


+ (NSURLRequest *)_searchRequestWithTerm:(NSString *)term location:(NSString *)location sortFilter:(int)sortFilter {
	NSDictionary *params = @{
							 @"term": term,
							 @"location": location,
							 @"limit": kSearchLimit,
							 @"category_filter":@"restaurants",
							 @"radius_filter":@"16093",
							 @"sort":[NSString stringWithFormat:@"%d", sortFilter]
							 };
	
	return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:params];
}



@end