//
//  TableViewManager.h
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YelpBusiness.h"

@protocol TableViewCellDelegate;
@protocol TableViewManagerDelegate;

@interface TableViewManager : NSObject <UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate>


@property (weak, nonatomic) id <TableViewManagerDelegate> delegate;
@property (strong) NSArray *data;

- (id)initWithDelegate:(id <TableViewManagerDelegate>)delegate;


@end

@protocol TableViewManagerDelegate <NSObject>

@optional
- (void)didSelectBusiness:(NSDictionary *)business;
- (void)didTouchFavoriteButtonAtIndexPath:(NSIndexPath *)indexPath;

@end