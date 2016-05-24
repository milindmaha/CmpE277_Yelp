//
//  FirstViewController.m
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import "FirstViewController.h"
#import "TableViewManager.h"
#import "YelpConnectionUtility.h"
#import "QueryManager.h"
#import "YelpBusiness+DisplayBusiness.h"

@import GoogleMaps;

@interface FirstViewController () <CLLocationManagerDelegate> {
	
	TableViewManager *tableViewManager;
	GMSPlacePicker *_placePicker;
}

@property (strong) NSDictionary *selectedBusiness;
@property (strong) NSArray *businessInfo;

@end

@implementation FirstViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	tableViewManager = [[TableViewManager alloc] initWithDelegate:self];
	_tableView.dataSource = tableViewManager;
	_tableView.delegate = tableViewManager;
	
	self.title = @"Search";
}

- (void)viewWillAppear:(BOOL)animated {
	
	[_searchTextField resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
	
	[_tableView reloadData];
}

- (void)didReceiveMemoryWarning {

	[super didReceiveMemoryWarning];
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

	[textField resignFirstResponder];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
	
	[textField setText:@""];
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

	[textField resignFirstResponder];
	return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	BusinessDetailViewController *businessDetailViewController = segue.destinationViewController;
	businessDetailViewController.selectedBusiness = self.selectedBusiness;
	businessDetailViewController.delegate = self;
}


#pragma mark - TableViewManagerDelegate

- (void)didSelectBusiness:(NSDictionary *)business {
	
	self.selectedBusiness = business;
	[self performSegueWithIdentifier:@"searchToDetailsSegue" sender:nil];
}

- (void)didTouchFavoriteButtonAtIndexPath:(NSIndexPath *)indexPath {
	
	if (![QueryManager isPresent:[[self.businessInfo objectAtIndex:indexPath.row] objectForKey:@"businessId"]]) {
		
		[QueryManager saveBusiness:[self.businessInfo objectAtIndex:indexPath.row] onCompletion:^(BOOL isSuccess) {
			
			dispatch_async(dispatch_get_main_queue(), ^{

				[_tableView reloadData];
			});
		}];
	} else {
		
		[QueryManager deleteBusiness:[[self.businessInfo objectAtIndex:indexPath.row] objectForKey:@"businessId"] onCompletion:^(BOOL isSuccess) {
			
			dispatch_async(dispatch_get_main_queue(), ^{
				
				[_tableView reloadData];
			});
		}];
	}
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


- (IBAction)didTouchGetLocationButton:(UIButton *)sender {
	
	[_searchTextField resignFirstResponder];

	CLLocationCoordinate2D center = CLLocationCoordinate2DMake(37.3352, -121.8811);
	CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(center.latitude + 0.001,
																  center.longitude + 0.001);
	CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(center.latitude - 0.001,
																  center.longitude - 0.001);
	GMSCoordinateBounds *viewport = [[GMSCoordinateBounds alloc] initWithCoordinate:northEast
																		 coordinate:southWest];
	GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:viewport];
	_placePicker = [[GMSPlacePicker alloc] initWithConfig:config];
	
	[_placePicker pickPlaceWithCallback:^(GMSPlace *place, NSError *error) {
		
		if (error != nil) {
			
			NSLog(@"Pick Place error %@", [error localizedDescription]);
			return;
		}
		
		if (place != nil) {
			
			self.selectedLocationTextField.text = place.name;
		} else {
			
			self.selectedLocationTextField.text = @"No place selected";
		}
	}];
}


- (IBAction)didTouchSearchButton:(UIButton *)sender {
	
	[_searchTextField resignFirstResponder];

	[self searchBy:0];
}

- (IBAction)didTouchSortByDistanceButton:(id)sender {
	
	[self searchBy:1];
}

- (IBAction)didTouchSortByRelevanceButton:(id)sender {
	
	[self searchBy:2];
}


- (void)searchBy:(int)sortFilter {
	
	if ([[_searchTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0) {
		
		dispatch_group_t requestGroup = dispatch_group_create();
		
		dispatch_group_enter(requestGroup);
		
		[YelpConnectionUtility getBusinessInfoFor:_searchTextField.text
									   inLocation:_selectedLocationTextField.text
								   withSortFilter:sortFilter
									 onCompletion:^(NSArray *businessArray, NSError *error) {
										 
										 if (error) {
											 
											 NSLog(@"Error: %@", error);
										 } else if (businessArray) {
											 
											 [self refresh:businessArray];
										 } else {
											 
											 dispatch_async(dispatch_get_main_queue(), ^{
												 
												 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No data found" message:@"" preferredStyle:UIAlertControllerStyleAlert];
												 
												 UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
													 
												 }];
												 [alertController addAction:dismissAction];
												 [self presentViewController:alertController animated:YES completion:^{
													 
												 }];
											 });
										 }
										 
										 dispatch_group_leave(requestGroup);
									 }];
		
		dispatch_group_wait(requestGroup, DISPATCH_TIME_FOREVER);
	}
}

- (void)refresh:(NSArray *)businessObjects {
	
	[_searchTextField resignFirstResponder];

	dispatch_async(dispatch_get_main_queue(), ^{

		self.businessInfo = [YelpBusiness parseObjects:businessObjects];
		tableViewManager.data = self.businessInfo;
		[_tableView reloadData];
	});
}


@end
