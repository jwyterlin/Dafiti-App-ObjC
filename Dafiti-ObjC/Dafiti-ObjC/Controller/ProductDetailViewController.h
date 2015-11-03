//
//  ProductDetailViewController.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 03/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericViewController.h"

// Model
#import "ProductModel.h"

@interface ProductDetailViewController : GenericViewController

@property(nonatomic,strong) ProductModel *product;

@end
