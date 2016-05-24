//
//  TableViewCell.h
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpBusiness.h"

@protocol TableViewCellDelegate;

@interface TableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITextView *businessAddressTextView;
@property (weak, nonatomic) IBOutlet UIImageView *businessRatingImage;
@property (weak, nonatomic) IBOutlet UITextField *businessNameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *businessImageIcon;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;


@property (weak, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) id <TableViewCellDelegate> delegate;


- (IBAction)didTouchFavoriteButton:(id)sender;
- (void)floodData:(NSDictionary *)dictionary;


@end


@protocol TableViewCellDelegate <NSObject>

@optional
- (void)tableViewCell:(TableViewCell *)cell didTouchFavoriteButtonAtIndexPath:(NSIndexPath *)indexPath;

@end