//
//  ProductDetailViewController.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 03/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ProductDetailViewController.h"

// Util
#import "CellHelper.h"

// Custom Cells
#import "ImageCell.h"
#import "ProductInfoCell.h"
#import "ProductNameCell.h"

// Categories
#import "UITableView+Helper.h"

@interface ProductDetailViewController()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) IBOutlet UITableView *tableView;

@end

@implementation ProductDetailViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"Product Detail";
    
    [self.tableView registerNibForCellReuseIdentifier:kNibNameProductNameCell];
    [self.tableView registerNibForCellReuseIdentifier:kNibNameImageCell];
    [self.tableView registerNibForCellReuseIdentifier:kNibNameProductInfoCell];
    [self.tableView removeSeparator];
    
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
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ( indexPath.row == 0 ) {
        return [[ProductNameCell new] productNameCellAtIndexPath:indexPath tableView:tableView product:self.product];
    } else if ( indexPath.row == 1 ) {
        return [[ImageCell new] imageCellAtIndexPath:indexPath tableView:tableView product:self.product];
    } else if ( indexPath.row == 2 ) {
        return [[ProductInfoCell new] productInfoCellAtIndexPath:indexPath tableView:tableView product:self.product];
    }
    
    return [UITableViewCell new];
    
}

#pragma mark - UITableViewDelegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier;
    
    if ( indexPath.row == 0 )
        identifier = kNibNameProductNameCell;
    else if ( indexPath.row == 1 )
        return 148;
    else if ( indexPath.row == 2 )
        identifier = kNibNameProductInfoCell;
    
    CGFloat height = [[CellHelper new] heightForCellAtIndexPath:indexPath tableView:tableView cellIdentifier:identifier delegate:self];
    
    return height;
    
}

#pragma mark - CellHelperDelegate Methods

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    if ( indexPath.row == 0 ) {
        ProductNameCell *customCell = (ProductNameCell *)cell;
        [customCell configureProductNameCell:customCell tableView:self.tableView indexPath:indexPath product:self.product];
    } else if ( indexPath.row == 1 ) {
        ImageCell *customCell = (ImageCell *)cell;
        [customCell configureImageCell:customCell tableView:self.tableView indexPath:indexPath product:self.product];
    } else if ( indexPath.row == 2 ) {
        ProductInfoCell *customCell = (ProductInfoCell *)cell;
        [customCell configureProductInfoCell:customCell tableView:self.tableView indexPath:indexPath product:self.product];
    }
    
}


@end
