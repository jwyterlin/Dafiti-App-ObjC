//
//  ProductModel.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericModel.h"

@interface ProductModel : GenericModel

@property(nonatomic,readonly) NSString *name;
@property(nonatomic,readonly) NSString *longDescription;
@property(nonatomic,readonly) NSString *manufacturer;
@property(nonatomic,readonly) NSNumber *salePrice;
@property(nonatomic,readonly) NSString *url;
@property(nonatomic,readonly) NSString *imageUrl;
@property(nonatomic,strong) NSData *image;
@property(nonatomic,readonly) NSString *largeFrontImageUrl;
@property(nonatomic,strong) NSData *largeFrontImage;

@end
