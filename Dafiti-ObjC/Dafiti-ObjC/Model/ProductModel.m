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
    
    _name = json[@"name"];
    _manufacturer = json[@"manufacturer"];
    _salePrice = [NSNumber numberWithDouble:[json[@"salePrice"] doubleValue]];
    _imageUrl = json[@"image"];
    _largeFrontImageUrl = json[@"largeFrontImage"];
    
    return self;
    
}

@end
