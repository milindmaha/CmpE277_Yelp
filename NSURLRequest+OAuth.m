//
//  NSURLRequest+OAuth.m
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import "NSURLRequest+OAuth.h"
#import <TDOAuth/TDOAuth.h>


static NSString * const kConsumerKey = @"";
static NSString * const kConsumerSecret = @"";
static NSString * const kToken = @"";
static NSString * const kTokenSecret = @"";


@implementation NSURLRequest (OAuth)


+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path {
	
	return [self requestWithHost:host path:path params:nil];
}

+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)params {
	
	if ([kConsumerKey length] == 0 || [kConsumerSecret length] == 0 || [kToken length] == 0 || [kTokenSecret length] == 0) {
		
		NSLog(@"Invalid credentials");
	}
	
	return [TDOAuth URLRequestForPath:path
						GETParameters:params
							   scheme:@"https"
								 host:host
						  consumerKey:kConsumerKey
					   consumerSecret:kConsumerSecret
						  accessToken:kToken
						  tokenSecret:kTokenSecret];
}


@end