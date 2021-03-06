//
//  Constants.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

extern NSString *const kAppDomain;
extern NSString *const kBestBuyAPIKey;
extern NSString *const kPipe;
extern NSString *const kCachedImages;

// Parameter Names
extern NSString *const kParameterImage;
extern NSString *const kParameterLargeFrontImage;
extern NSString *const kParameterLongDescription;
extern NSString *const kParameterManufacturer;
extern NSString *const kParameterName;
extern NSString *const kParameterPage;
extern NSString *const kParameterPageSize;
extern NSString *const kParameterProducts;
extern NSString *const kParameterSalePrice;
extern NSString *const kParameterShow;
extern NSString *const kParameterUrl;
extern NSString *const kParameterSKU;

// Cell Nib Names
extern NSString *const kNibNameProductCell;
extern NSString *const kNibNameImageCell;
extern NSString *const kNibNameProductNameCell;
extern NSString *const kNibNameProductInfoCell;

extern const int INTERVAL_PRODUCTS;

@end
