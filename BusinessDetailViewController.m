//
//  BusinessDetailViewController.m
//  CmpE277_Yelp
//
//  Created by Milind on 5/22/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import "BusinessDetailViewController.h"
#import "QueryManager.h"
#import "YelpBusiness+DisplayBusiness.h"
#import "StreetViewController.h"
#import "Annotation.h"
#import "UIColor+HexColor.h"

@interface BusinessDetailViewController ()

@end

@implementation BusinessDetailViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
	[rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
	[self.view addGestureRecognizer:rightSwipe];

	UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
	[leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
	[self.view addGestureRecognizer:leftSwipe];
	
	UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, _phoneNumberTextField.frame.size.height)];
	_phoneNumberTextField.leftView = paddingView;
	_phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)viewDidAppear:(BOOL)animated {

	[self refresh];
}

- (void)didReceiveMemoryWarning {
	
	[super didReceiveMemoryWarning];
}


- (void)rightSwipe:(id)sender {
	
	if ([_delegate respondsToSelector:@selector(getPreviousBusiness:)]) {
		
		dispatch_async(dispatch_get_main_queue(), ^{
			
			NSDictionary *previousBuisness = [_delegate getPreviousBusiness:self.selectedBusiness];
			
			if (previousBuisness) {
    
				self.selectedBusiness = previousBuisness;
				[self refresh];
			}
		});
	}
}

- (void)leftSwipe:(id)sender {
	
	if ([_delegate respondsToSelector:@selector(getNextBusiness:)]) {
		
		dispatch_async(dispatch_get_main_queue(), ^{
			
			NSDictionary *nextBuisness = [_delegate getNextBusiness:self.selectedBusiness];
			
			if (nextBuisness) {
    
				self.selectedBusiness = nextBuisness;
				[self refresh];
			}
		});
	}
}


#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {

	return NO;
}


- (IBAction)didTouchFavoriteButton:(id)sender {
	
	if (![QueryManager isPresent:[self.selectedBusiness objectForKey:@"businessId"]]) {
		
		[QueryManager saveBusiness:self.selectedBusiness onCompletion:^(BOOL isSuccess) {
			
			[self refresh];
		}];
	} else {
		
		[QueryManager deleteBusiness:[self.selectedBusiness objectForKey:@"businessId"] onCompletion:^(BOOL isSuccess) {
			
			[self refresh];
		}];
	}
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	StreetViewController *streetViewController = segue.destinationViewController;

	CLLocationCoordinate2D coordinates;
	coordinates.latitude = [[self.selectedBusiness objectForKey:@"latitude"] doubleValue];
	coordinates.longitude = [[self.selectedBusiness objectForKey:@"longitude"] doubleValue];
	
	streetViewController.coordinates = coordinates;
}

- (IBAction)didTouchStreetViewButton:(id)sender {
	
	[self performSegueWithIdentifier:@"ShowStreetViewSegue" sender:nil];
}

- (void)refresh {
	
	[self setTitle:[self.selectedBusiness objectForKey:@"name"]];
	[_addressTextView setText:[self.selectedBusiness objectForKey:@"address"]];
	[_reviewCountLabel setText:[NSString stringWithFormat:@"%@ reviews", [self.selectedBusiness objectForKey:@"reviews"]]];
	[_phoneNumberTextField setText:[self.selectedBusiness objectForKey:@"phoneNumber"]];

	NSURLSession *iconImageSession = [NSURLSession sharedSession];
	[[iconImageSession dataTaskWithURL:[NSURL URLWithString:[self.selectedBusiness objectForKey:@"imageUrl"]]
			completionHandler:^(NSData *data,
								NSURLResponse *response,
								NSError *error) {
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					[_iconImageView setImage:[UIImage imageWithData:data]];
				});
			}] resume];
	
	NSURLSession *ratingImageSession = [NSURLSession sharedSession];
	[[ratingImageSession dataTaskWithURL:[NSURL URLWithString:[self.selectedBusiness objectForKey:@"ratingUrl"]]
			completionHandler:^(NSData *data,
								NSURLResponse *response,
								NSError *error) {
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					[_ratingImageView setImage:[UIImage imageWithData:data]];
				});
			}] resume];

	NSLog(@"Snippet url: %@", [self.selectedBusiness objectForKey:@"snippetUrl"]);
	NSURLSession *snippetImageSession = [NSURLSession sharedSession];
	[[snippetImageSession dataTaskWithURL:[NSURL URLWithString:[self.selectedBusiness objectForKey:@"snippetUrl"]]
			completionHandler:^(NSData *data,
								NSURLResponse *response,
								NSError *error) {
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					[_snippetImageView setImage:[UIImage imageWithData:data]];
				});
			}] resume];
	
	[_snippetTextView setText:[self.selectedBusiness objectForKey:@"snippetText"]];

	if ([QueryManager isPresent:[self.selectedBusiness objectForKey:@"businessId"]]) {
		
		[_favoriteButton setBackgroundImage:[UIImage imageNamed:@"fav_red"] forState:UIControlStateNormal];
	} else {
		
		[_favoriteButton setBackgroundImage:[UIImage imageNamed:@"fav_black"] forState:UIControlStateNormal];
	}
	
	MKCoordinateSpan span;
	span.latitudeDelta = 0.002;
	span.longitudeDelta = 0.002;
	
	CLLocationCoordinate2D location;
	location.latitude = [[self.selectedBusiness objectForKey:@"latitude"] doubleValue];
	location.longitude = [[self.selectedBusiness objectForKey:@"longitude"] doubleValue];
	
	MKCoordinateRegion region;
	region.span = span;
	region.center = location;

	[_mapView setRegion:region animated:YES];
	
	Annotation *annotation = [[Annotation alloc] initWithCoordinate:location];
	[_mapView addAnnotation:annotation];
}


@end