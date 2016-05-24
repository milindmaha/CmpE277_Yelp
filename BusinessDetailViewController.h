//
//  BusinessDetailViewController.h
//  CmpE277_Yelp
//
//  Created by Milind on 5/22/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "YelpBusiness.h"


@protocol BusinessDetailViewControllerDelegate <NSObject>

@optional
- (NSDictionary *)getNextBusiness:(NSDictionary *)currentBusiness;
- (NSDictionary *)getPreviousBusiness:(NSDictionary *)currentBusiness;

@end

@interface BusinessDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextView *snippetTextView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *snippetImageView;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *streetViewButton;


@property (strong, nonatomic) NSDictionary *selectedBusiness;


@property (weak, nonatomic) id <BusinessDetailViewControllerDelegate> delegate;


@end