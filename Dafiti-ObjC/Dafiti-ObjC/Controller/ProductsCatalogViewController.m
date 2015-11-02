//
//  ProductsCatalogViewController.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ProductsCatalogViewController.h"

// Service
#import "ProductService.h"

// Custom Cells
#import "ProductCell.h"

@interface ProductsCatalogViewController()<UITableViewDataSource,UITableViewDelegate>

@property(weak,nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSMutableArray *products;

@end

@implementation ProductsCatalogViewController

#pragma mark - View Lifecycle

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self downloadProducts];
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductModel *product = self.products[indexPath.row];
    return [[ProductCell new] productCellAtIndexPath:indexPath tableView:tableView product:product];
    
}

#pragma mark - UITableViewDelegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105.0;
}

#pragma makr - Private methods

-(void)downloadProducts {
    
    NSNumber *page = [NSNumber numberWithInt:1];
    NSNumber *limit = [NSNumber numberWithInt:15];
    
    [[ProductService new] productsListWithTerm:@"MacBook" page:page limit:limit completion:^(NSArray *products, BOOL hasNoConnection, NSError *error) {
        
        if ( hasNoConnection ) {
            // TODO: Show alert no connection
            return;
        }
        
        if ( error ) {
            // TODO: Show alert error
            return;
        }
        
        [self.products addObjectsFromArray:products];
        [self.tableView reloadData];
        
    }];
    
}

#pragma mark - Lazy instances

-(NSMutableArray *)products {
    
    if ( ! _products )
        _products = [NSMutableArray new];
    return _products;
    
}

@end
