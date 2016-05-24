//
//  TableViewCell.m
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import "TableViewCell.h"
#import "UIColor+HexColor.h"
#import "QueryManager.h"


@implementation TableViewCell


- (void)awakeFromNib {

	[super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];
}


- (IBAction)didTouchFavoriteButton:(id)sender {
	
	if ([_delegate respondsToSelector:@selector(tableViewCell:didTouchFavoriteButtonAtIndexPath:)]) {
		
		dispatch_async(dispatch_get_main_queue(), ^{
			
			[_delegate tableViewCell:self didTouchFavoriteButtonAtIndexPath:_indexPath];
		});
	}
}

- (void)floodData:(NSDictionary *)dictionary {

	[_businessNameTextField setText:[dictionary objectForKey:@"name"]];
	[_businessAddressTextView setText:[dictionary objectForKey:@"address"]];

	NSURLSession *session = [NSURLSession sharedSession];

	[[session dataTaskWithURL:[NSURL URLWithString:[dictionary objectForKey:@"imageUrl"]]
			completionHandler:^(NSData *data,
								NSURLResponse *response,
								NSError *error) {
				
				dispatch_async(dispatch_get_main_queue(), ^{

					[_businessImageIcon setImage:[UIImage imageWithData:data]];
				});
			}] resume];

	[[session dataTaskWithURL:[NSURL URLWithString:[dictionary objectForKey:@"ratingUrl"]]
			completionHandler:^(NSData *data,
								NSURLResponse *response,
								NSError *error) {
				
				dispatch_async(dispatch_get_main_queue(), ^{
					
					[_businessRatingImage setImage:[UIImage imageWithData:data]];
					[_activityIndicator stopAnimating];
				});
			}] resume];
	
	if ([QueryManager isPresent:[dictionary objectForKey:@"businessId"]]) {
		
		[_favoriteButton setBackgroundImage:[UIImage imageNamed:@"fav_red"] forState:UIControlStateNormal];
	} else {
		
		[_favoriteButton setBackgroundImage:[UIImage imageNamed:@"fav_black"] forState:UIControlStateNormal];
	}

}


@end