//
//  NSURLRequest+OAuth.m
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (OAuth)


+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path;
+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)params;


@end