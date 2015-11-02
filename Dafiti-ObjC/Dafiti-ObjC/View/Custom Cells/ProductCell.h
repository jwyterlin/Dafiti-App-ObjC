//
//  ProductCell.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericCell.h"

// Model
#import "ProductModel.h"

@interface ProductCell : GenericCell

-(ProductCell *)productCellAtIndexPath:(NSIndexPath *)indexPath
                             tableView:(UITableView *)tableView
                               product:(ProductModel *)product;

-(void)configureProductCell:(ProductCell *)cell
                  tableView:(UITableView *)tableView
                  indexPath:(NSIndexPath *)indexPath
                    product:(ProductModel *)product;

@end
