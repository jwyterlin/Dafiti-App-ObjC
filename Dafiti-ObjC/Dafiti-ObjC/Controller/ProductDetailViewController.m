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

@interface ProductDetailViewController()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic,weak) IBOutlet UIImageView *photo;

@end

@implementation ProductDetailViewController

-(void)viewDidLoad {
    [super viewDidLoad];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UITableViewCell new];
    
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


@end
