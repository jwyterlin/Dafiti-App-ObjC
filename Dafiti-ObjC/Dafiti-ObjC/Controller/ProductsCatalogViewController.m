//
//  ProductsCatalogViewController.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ProductsCatalogViewController.h"

#import "ProductService.h"

@interface ProductsCatalogViewController ()

@end

@implementation ProductsCatalogViewController

#pragma mark - View Lifecycle

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSNumber *page = [NSNumber numberWithInt:1];
    NSNumber *limit = [NSNumber numberWithInt:15];
    
    [[ProductService new] productsListWithTerm:@"MacBook" page:page limit:limit completion:^(NSArray *products, BOOL hasNoConnection, NSError *error) {
        
    }];
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
