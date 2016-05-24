//
//  QueryManager.h
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^SaveBlockResponse) (BOOL isSuccess);
typedef void (^DeleteBlockResponse) (BOOL isSuccess);


@interface QueryManager : NSObject

+ (void)saveBusiness:(NSDictionary *)buizInfo onCompletion:(SaveBlockResponse)onCompletion;
+ (void)deleteBusiness:(NSString *)businessId onCompletion:(DeleteBlockResponse)onCompletion;
+ (NSArray *)fetchAllBusinesses;
+ (BOOL)isPresent:(NSString *)buizId;


@end