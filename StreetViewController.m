//
//  StreetViewController.m
//  CmpE277_Yelp
//
//  Created by Milind on 5/23/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import "StreetViewController.h"

@import GoogleMaps;

@interface StreetViewController ()

@end

@implementation StreetViewController

- (void)viewDidLoad {
	
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
	
	CLLocationCoordinate2D panoramaNear = _coordinates;
	GMSPanoramaView *panoView = [GMSPanoramaView panoramaWithFrame:self.view.bounds nearCoordinate:panoramaNear];
	self.view = panoView;
}

- (void)didReceiveMemoryWarning {

	[super didReceiveMemoryWarning];
}


@end