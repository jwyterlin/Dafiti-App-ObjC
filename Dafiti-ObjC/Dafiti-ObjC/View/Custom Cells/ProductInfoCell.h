//
//  ProductInfoCell.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 03/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericCell.h"

// Model
#import "ProductModel.h"

@interface ProductInfoCell : GenericCell

-(ProductInfoCell *)productInfoCellAtIndexPath:(NSIndexPath *)indexPath
                                     tableView:(UITableView *)tableView
                                       product:(ProductModel *)product;

-(void)configureProductInfoCell:(ProductInfoCell *)cell
                      tableView:(UITableView *)tableView
                      indexPath:(NSIndexPath *)indexPath
                        product:(ProductModel *)product;

@end
