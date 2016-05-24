//
//  SecondViewController.m
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import "SecondViewController.h"
#import "TableViewManager.h"
#import "QueryManager.h"
#import "YelpBusiness+DisplayBusiness.h"

@interface SecondViewController () {
	
	TableViewManager *tableViewManager;
}

@property (strong) NSDictionary *selectedBusiness;
@property (strong) NSArray *businessInfo;
@end

@implementation SecondViewController

- (void)viewDidLoad {

	[super viewDidLoad];

	tableViewManager = [[TableViewManager alloc] initWithDelegate:self];
	_tableView.dataSource = tableViewManager;
	_tableView.delegate = tableViewManager;
	
	self.automaticallyAdjustsScrollViewInsets = NO;

	self.title = @"Favorites";
}

- (void)viewDidAppear:(BOOL)animated {
	
	[self refresh];
}

- (void)didReceiveMemoryWarning {

	[super didReceiveMemoryWarning];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	BusinessDetailViewController *businessDetailViewController = segue.destinationViewController;
	businessDetailViewController.selectedBusiness = self.selectedBusiness;
	businessDetailViewController.delegate = self;
}


#pragma mark - TableViewManagerDelegate

- (void)didSelectBusiness:(NSDictionary *)business {
	
	self.selectedBusiness = business;
	[self performSegueWithIdentifier:@"favoritesToDetailsSegue" sender:nil];
}


- (NSDictionary *)getNextBusiness:(NSDictionary *)currentBusiness {
	
	self.selectedBusiness = currentBusiness;
	int index = [self.businessInfo indexOfObject:self.selectedBusiness];

	if (index < self.businessInfo.count-1) {
		
		return [self.businessInfo objectAtIndex:index+1];
	}
	return nil;
}

- (NSDictionary *)getPreviousBusiness:(NSDictionary *)currentBusiness {
	
	self.selectedBusiness = currentBusiness;
	int index = [self.businessInfo indexOfObject:self.selectedBusiness];
	if (index > 0) {
		
		return [self.businessInfo objectAtIndex:index-1];
	}
	return nil;
}

- (void)refresh {
	
	NSArray *buizObjects = [QueryManager fetchAllBusinesses];
	
	if (buizObjects.count) {
		
		[_tableView setHidden:NO];
		[_noFavoritesLabel setHidden:YES];
		
		self.businessInfo = [YelpBusiness parseObjects:buizObjects];
		tableViewManager.data = self.businessInfo;
		[_tableView reloadData];
	} else {
		
		[_tableView setHidden:YES];
		[_noFavoritesLabel setHidden:NO];
	}
}


@end