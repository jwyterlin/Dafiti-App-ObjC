//
//  ProductModel.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

#pragma mark - Overriding super methods

-(ProductModel *)setupWithJson:(NSDictionary *)json {
    
    if ( ! [Validator validateObject:json] )
        return nil;
    
    return [[ProductModel new] newProductWithJson:json];
    
}

#pragma mark - Private methods

-(ProductModel *)newProductWithJson:(NSDictionary *)json {
    
    _name = json[kParameterName];
    _longDescription = json[kParameterLongDescription];
    _manufacturer = json[kParameterManufacturer];
    _salePrice = [NSNumber numberWithDouble:[json[kParameterSalePrice] doubleValue]];
    _imageUrl = json[kParameterImage];
    _largeFrontImageUrl = json[kParameterLargeFrontImage];
    _url = json[kParameterUrl];
    
    return self;
    
}

@end
