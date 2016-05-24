//
//  TableViewManager.m
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import "TableViewManager.h"
#import "TableViewCell.h"


@interface TableViewManager ()

@end


@implementation TableViewManager


- (id)initWithDelegate:(id <TableViewManagerDelegate>)delegate {
	
	if (self = [super init]) {
		
		_delegate = delegate;
	}
	
	return self;
}


#pragma - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *reuseIdentifier = @"TableViewCell";
	
	TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
	cell.indexPath = indexPath;
	cell.delegate = self;
	[cell floodData:[self.data objectAtIndex:indexPath.row]];
	
	return cell;
}



#pragma - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if ([_delegate respondsToSelector:@selector(didSelectBusiness:)]) {
		
		dispatch_async(dispatch_get_main_queue(), ^{
			
			[_delegate didSelectBusiness:[self.data objectAtIndex:indexPath.row]];
		});
	}
}


#pragma mark - TableViewCellDelegate

- (void)tableViewCell:(TableViewCell *)cell didTouchFavoriteButtonAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([_delegate respondsToSelector:@selector(didTouchFavoriteButtonAtIndexPath:)]) {
		
		dispatch_async(dispatch_get_main_queue(), ^{
			
			[_delegate didTouchFavoriteButtonAtIndexPath:indexPath];
		});
	}
}


@end