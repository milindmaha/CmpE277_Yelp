//
//  DBManager.m
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import "DBManager.h"



static DBManager *sharedManager = nil;

@implementation DBManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (DBManager *)sharedManager {
	
	@synchronized(self) {
		
		if (sharedManager == nil) {
			
			sharedManager = [[self alloc] init];
		}
	}
	return sharedManager;
}


- (id)init {
	
	if (self = [super init]) {
		
		[self managedObjectContext];
	}
	
	return self;
}

- (NSURL *)applicationDocumentsDirectory {

	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {

	if (_managedObjectModel != nil) {

		return _managedObjectModel;
	}
	
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

	return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {

	if (_persistentStoreCoordinator != nil) {

		return _persistentStoreCoordinator;
	}

	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
	NSError *error = nil;
	NSString *failureReason = @"There was an error creating or loading the application's saved data.";

	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {

		NSMutableDictionary *dict = [NSMutableDictionary dictionary];
		dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
		dict[NSLocalizedFailureReasonErrorKey] = failureReason;
		dict[NSUnderlyingErrorKey] = error;
		error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];

		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {

	if (_managedObjectContext != nil) {
		
		return _managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	
	if (!coordinator) {
		
		return nil;
	}
	
	_managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	[_managedObjectContext setPersistentStoreCoordinator:coordinator];
	
	return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
	
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
	
	if (managedObjectContext != nil) {
	
		NSError *error = nil;
		
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {

			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}


@end
