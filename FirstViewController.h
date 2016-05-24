//
//  FirstViewController.h
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessDetailViewController.h"


@protocol TableViewManagerDelegate;

@interface FirstViewController : UIViewController <TableViewManagerDelegate, BusinessDetailViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sortByRelevanceButton;
@property (weak, nonatomic) IBOutlet UIButton *sortByDistanceButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UITextField *selectedLocationTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (nonatomic, weak) IBOutlet UITextField *searchTextField;
@end