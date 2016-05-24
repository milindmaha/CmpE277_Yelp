//
//  SecondViewController.h
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessDetailViewController.h"


@protocol TableViewManagerDelegate;

@interface SecondViewController : UIViewController <TableViewManagerDelegate, BusinessDetailViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *noFavoritesLabel;

@end