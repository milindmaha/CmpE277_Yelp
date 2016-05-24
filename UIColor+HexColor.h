//
//  UIColor+HexColor.h
//  CmpE277_Yelp
//
//  Created by Milind on 5/21/16.
//  Copyright © 2016 Milind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *)colorFromHex:(NSString*)hexColor;

@end