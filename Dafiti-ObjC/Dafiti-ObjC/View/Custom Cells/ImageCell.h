//
//  ImageCell.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 03/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericCell.h"

// Model
#import "ProductModel.h"

@interface ImageCell : GenericCell

-(ImageCell *)imageCellAtIndexPath:(NSIndexPath *)indexPath
                         tableView:(UITableView *)tableView
                           product:(ProductModel *)product;

-(void)configureImageCell:(ImageCell *)cell
                tableView:(UITableView *)tableView
                indexPath:(NSIndexPath *)indexPath
                  product:(ProductModel *)product;

@end
