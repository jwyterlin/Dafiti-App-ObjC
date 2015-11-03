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

// Categories
#import "UITableView+Helper.h"

// Util
#import "CellHelper.h"

@interface ProductsCatalogViewController()<UITableViewDataSource,UITableViewDelegate,CellHelperDelegate>

@property(weak,nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSMutableArray *products;

@property(nonatomic,strong) UIRefreshControl *refresh;
@property(nonatomic) BOOL needsCleanProducts;

@end

@implementation ProductsCatalogViewController

#pragma mark - View Lifecycle

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"Products";
    
    [self.tableView registerNibForCellReuseIdentifier:kNibNameProductCell];
    [self.tableView removeSeparator];
    [self.tableView addSubview:self.refresh];
    
    [self downloadProducts];
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [self.tableView reloadData];
    
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
    
    CGFloat height = [[CellHelper new] heightForCellAtIndexPath:indexPath tableView:tableView cellIdentifier:kNibNameProductCell delegate:self];
    return height;
    
}

#pragma mark - CellHelperDelegate Methods

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    ProductCell *customCell = (ProductCell *)cell;
    
    ProductModel *product = self.products[indexPath.row];
    
    [customCell configureProductCell:customCell tableView:self.tableView indexPath:indexPath product:product];
    
}

#pragma mark - Private methods

-(void)didRefresh {
    
    self.needsCleanProducts = YES;
    
    [self downloadProducts];
    
}

-(void)downloadProducts {
    
    NSNumber *page = [NSNumber numberWithInt:1];
    NSNumber *limit = [NSNumber numberWithInt:15];
    
    [[Indicator shared] showIndicatorWithLabel:@"Loading Products..." viewController:self];
    
    [[ProductService new] productsListWithTerm:@"MacBook" page:page limit:limit completion:^(NSArray *products, BOOL hasNoConnection, NSError *error) {
        
        [self.refresh endRefreshing];
        
        [[Indicator shared] stopIndicatorInViewController:self];
        
        if ( hasNoConnection ) {
            // TODO: Show alert no connection
            return;
        }
        
        if ( error ) {
            // TODO: Show alert error
            return;
        }
        
        if ( self.needsCleanProducts ) {
            self.needsCleanProducts = NO;
            [self.products removeAllObjects];
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

-(UIRefreshControl *)refresh {
    
    if ( ! _refresh ) {
        _refresh = [UIRefreshControl new];
        [_refresh addTarget:self action:@selector(didRefresh) forControlEvents:UIControlEventValueChanged];
        _refresh.tintColor = [UIColor lightGrayColor];
    }
    
    return _refresh;
    
}

@end
