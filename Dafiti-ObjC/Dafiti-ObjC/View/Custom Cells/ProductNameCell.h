//
//  ProductNameCell.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 03/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericCell.h"

// Model
#import "ProductModel.h"

@interface ProductNameCell : GenericCell

-(ProductNameCell *)productNameCellAtIndexPath:(NSIndexPath *)indexPath
                                     tableView:(UITableView *)tableView
                                       product:(ProductModel *)product;

-(void)configureProductNameCell:(ProductNameCell *)cell
                      tableView:(UITableView *)tableView
                      indexPath:(NSIndexPath *)indexPath
                        product:(ProductModel *)product;

@end
