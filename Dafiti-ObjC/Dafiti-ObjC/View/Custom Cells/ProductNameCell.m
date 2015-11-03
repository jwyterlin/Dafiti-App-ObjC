//
//  ProductNameCell.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 03/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ProductNameCell.h"

@interface ProductNameCell()

@property(weak,nonatomic) IBOutlet CellLabel *name;
@property(weak,nonatomic) IBOutlet NSLayoutConstraint *nameWidth;

@end

@implementation ProductNameCell

-(void)awakeFromNib {
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Public methods

-(ProductNameCell *)productNameCellAtIndexPath:(NSIndexPath *)indexPath
                                     tableView:(UITableView *)tableView
                                       product:(ProductModel *)product {
    
    ProductNameCell *cell = [tableView dequeueReusableCellWithIdentifier:kNibNameProductNameCell forIndexPath:indexPath];
    [self configureProductNameCell:cell tableView:tableView indexPath:indexPath product:product];
    
    return cell;
    
}

-(void)configureProductNameCell:(ProductNameCell *)cell
                      tableView:(UITableView *)tableView
                      indexPath:(NSIndexPath *)indexPath
                        product:(ProductModel *)product {
    
    if ( product == nil ) {
        
        cell.name.text = @"";
        
        return;
        
    }
    
    cell.name.text = product.name;
    
    int rightWidth = tableView.width - cell.name.x - 8;
    
    if ( cell.nameWidth.constant != rightWidth )
        cell.nameWidth.constant = rightWidth;
    
    [cell.name setNeedsUpdateConstraints];
    
}

@end
