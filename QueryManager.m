//
//  QueryManager.m
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import "QueryManager.h"
#import "DBManager.h"
#import "YelpBusiness.h"

@implementation QueryManager


+(NSEntityDescription *)getEntityDescriptionForClass:(NSString *)entity
{
	return [NSEntityDescription entityForName:entity inManagedObjectContext:[[DBManager sharedManager] managedObjectContext]];
}

+ (void)saveBusiness:(NSDictionary *)buizInfo onCompletion:(SaveBlockResponse)onCompletion {
	
	YelpBusiness *buiz = [[YelpBusiness alloc] initWithEntity:[QueryManager getEntityDescriptionForClass:NSStringFromClass([YelpBusiness class])] insertIntoManagedObjectContext:[[DBManager sharedManager] managedObjectContext]];
	
	NSString *buizId = [buizInfo objectForKey:@"businessId"];
	buiz.businessId = buizId;
	
	NSString *buizName = [buizInfo objectForKey:@"name"];
	buiz.name = buizName;
	
	NSString *buizRating = [NSString stringWithFormat:@"%@", [buizInfo objectForKey:@"rating"]];
	buiz.rating = buizRating;
	
	NSString *buizReviews = [buizInfo objectForKey:@"reviews"];
	buiz.reviews = buizReviews;
	
	NSString *buizContact = [buizInfo objectForKey:@"phoneNumber"];
	buiz.phoneNumber = buizContact;
	
	NSString *buizImageUrl = [buizInfo objectForKey:@"imageUrl"];
	buiz.imageUrl = buizImageUrl;
	
	NSString *buizRatingUrl = [buizInfo objectForKey:@"ratingUrl"];
	buiz.ratingUrl = buizRatingUrl;
	
	NSString *buizAddress = [buizInfo objectForKey:@"address"];
	buiz.address = buizAddress;
	
	NSString *buizSnippetUrl = [buizInfo objectForKey:@"snippetUrl"];
	buiz.snippetUrl = buizSnippetUrl;
	
	NSString *buizSnippetText = [buizInfo objectForKey:@"snippetText"];
	buiz.snippetText = buizSnippetText;
	
	NSString *buizLatitude = [buizInfo objectForKey:@"latitude"];
	buiz.latitude = buizLatitude;
	
	NSString *buizLongitude = [buizInfo objectForKey:@"longitude"];
	buiz.longitude = buizLongitude;

	if ([[[DBManager sharedManager] managedObjectContext] save:nil]) {
		
		onCompletion(YES);
	} else {
		
		onCompletion(NO);
	}
}

+ (BOOL)isPresent:(NSString *)buizId {
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	request.entity = [NSEntityDescription entityForName:NSStringFromClass([YelpBusiness class]) inManagedObjectContext:[[DBManager sharedManager] managedObjectContext]];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"businessId = %@", buizId];
	request.predicate = predicate;

	NSError *error = nil;

	NSUInteger count = [[[DBManager sharedManager] managedObjectContext] countForFetchRequest:request
																						error:&error];
	
	return (count != 0);
}

+ (void)deleteBusiness:(NSString *)businessId onCompletion:(DeleteBlockResponse)onCompletion {
	
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [QueryManager getEntityDescriptionForClass:NSStringFromClass([YelpBusiness class])];
    [fetchRequest setEntity:entity];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"businessId == %@", businessId];
    
    NSArray *fetchedObjects = [[[DBManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:nil];
    [[[DBManager sharedManager] managedObjectContext] deleteObject:[fetchedObjects lastObject]];

	if ([[[DBManager sharedManager] managedObjectContext] save:nil]) {
		
		onCompletion(YES);
	} else {
		
		onCompletion(NO);
	}
}

+ (NSArray *)fetchAllBusinesses {
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [QueryManager getEntityDescriptionForClass:NSStringFromClass([YelpBusiness class])];
	[fetchRequest setEntity:entity];
	
	NSArray *fetchedObjects = [[[DBManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:nil];

	return fetchedObjects;
}


@end