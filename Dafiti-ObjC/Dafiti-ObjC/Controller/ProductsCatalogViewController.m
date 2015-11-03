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

// Controller
#import "ProductDetailViewController.h"

@interface ProductsCatalogViewController()<UITableViewDataSource,UITableViewDelegate,CellHelperDelegate>

@property(weak,nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSMutableArray *products;

@property(nonatomic,strong) UIRefreshControl *refresh;
@property(nonatomic) BOOL needsCleanProducts;
@property(nonatomic) unsigned int page;
@property(nonatomic,strong) UIView *loadingView;
@property(nonatomic,strong) UIActivityIndicatorView *loading;

@end

@implementation ProductsCatalogViewController

#pragma mark - View Lifecycle

-(void)viewDidLoad {
    
    [super viewDidLoad];

    [self.tableView registerNibForCellReuseIdentifier:kNibNameProductCell];
    [self.tableView removeSeparator];
    [self.tableView addSubview:self.refresh];
    
    self.page = 1;
    
    [self downloadProducts];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Products";
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
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
    
    if ( indexPath.row == self.products.count - 1 )
        [self downloadProducts];
    
    ProductModel *product = self.products[indexPath.row];
    ProductCell *cell = [[ProductCell new] productCellAtIndexPath:indexPath tableView:tableView product:product];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = [[CellHelper new] heightForCellAtIndexPath:indexPath tableView:tableView cellIdentifier:kNibNameProductCell delegate:self];
    return height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductModel *product = self.products[indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ProductDetailViewController *viewControllerToPresent = [storyboard instantiateViewControllerWithIdentifier:@"ProductDetailViewController"];
    viewControllerToPresent.product = product;
    self.navigationItem.title = @"";
    
    [self.navigationController pushViewController:viewControllerToPresent animated:YES];
    
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

    unsigned int quantityProducts = (unsigned int)self.products.count;
    BOOL listIsEmpty  = quantityProducts == 0;
    BOOL willShowMore = quantityProducts >= INTERVAL_PRODUCTS && ( quantityProducts / INTERVAL_PRODUCTS ) >= self.page-1;
    
    if ( listIsEmpty || willShowMore ) {
        
        if ( ! willShowMore )
            [[Indicator shared] showIndicatorWithLabel:@"Loading Products..." viewController:self];

        NSNumber *page = [NSNumber numberWithInt:self.needsCleanProducts?1:self.page];
        NSNumber *limit = [NSNumber numberWithInt:INTERVAL_PRODUCTS];
        
        [[ProductService new] productsListWithTerm:@"MacBook" page:page limit:limit completion:^(NSArray *products, BOOL hasNoConnection, NSError *error) {
            
            [self.refresh endRefreshing];
            
            if ( ! willShowMore )
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
                self.page = 1;
                
            }
            
            [self.products addObjectsFromArray:products];
            [self.tableView reloadData];
            
            ++self.page;

            [self dismissLoadingMore];
            
        }];
        
        [self showLoadingMore];
        
    }
    
}

-(void)showLoadingMore {
    
    if ( self.page > 1 ) {
        
        CGRect frame     = self.loadingView.frame;
        frame.origin.y   = self.tableView.contentSize.height;
        
        self.loadingView.frame = frame;
        
        [self.tableView addSubview:self.loadingView];
        
        [self.loading startAnimating];
        
    }
    
}

-(void)dismissLoadingMore {
    
    if ( [self.loadingView isDescendantOfView:self.tableView] )
        [self.loadingView removeFromSuperview];
    
    [self.loading stopAnimating];
    
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

-(UIView *)loadingView {
    
    if ( ! _loadingView ) {
        
        _loadingView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, self.tableView.width, 30 )];
        _loadingView.backgroundColor = [UIColor clearColor];
        
        [_loadingView addSubview:self.loading];
        
    }
    
    return _loadingView;
    
}

-(UIActivityIndicatorView *)loading {
    
    if ( ! _loading ) {
        
        int width = 20;
        int height = 20;
        int x = ( self.loadingView.frame.size.width / 2 ) - ( width / 2 );
        int y = ( self.loadingView.frame.size.height / 2 ) - ( height / 2 );
        
        _loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loading.frame = CGRectMake( x, y, width, height );
        _loading.hidesWhenStopped = YES;
        
    }
    
    return _loading;
    
}


@end
