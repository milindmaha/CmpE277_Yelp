//
//  YelpConnectionUtility.h
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpConnectionUtility : NSObject

+ (void)getBusinessInfoFor:(NSString *)search inLocation:(NSString *)location withSortFilter:(int)sortFilter onCompletion:(void (^)(NSArray *jsonResponse, NSError *error))onCompletion;


@end
