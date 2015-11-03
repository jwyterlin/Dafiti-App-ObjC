//
//  ProductInfoCell.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 03/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ProductInfoCell.h"

@interface ProductInfoCell()

@property(weak,nonatomic) IBOutlet CellLabel *price;
@property(weak,nonatomic) IBOutlet CellLabel *longDescription;
@property(weak,nonatomic) IBOutlet NSLayoutConstraint *longDescriptionWidth;

@end

@implementation ProductInfoCell

-(void)awakeFromNib {
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Public methods

-(ProductInfoCell *)productInfoCellAtIndexPath:(NSIndexPath *)indexPath
                                     tableView:(UITableView *)tableView
                                       product:(ProductModel *)product {
    
    ProductInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kNibNameProductInfoCell forIndexPath:indexPath];
    [self configureProductInfoCell:cell tableView:tableView indexPath:indexPath product:product];
    
    return cell;
    
}

-(void)configureProductInfoCell:(ProductInfoCell *)cell
                      tableView:(UITableView *)tableView
                      indexPath:(NSIndexPath *)indexPath
                        product:(ProductModel *)product {
    
    if ( product == nil ) {
        
        cell.price.text = @"";
        
        return;
        
    }
    
    cell.price.text = [NSString stringWithFormat:@"$ %.2f", [product.salePrice doubleValue]];
    cell.longDescription.text = product.longDescription;
    
    int rightWidth = tableView.width - cell.longDescription.x - 8;
    
    if ( cell.longDescriptionWidth.constant != rightWidth )
        cell.longDescriptionWidth.constant = rightWidth;
    
    [cell.longDescription setNeedsUpdateConstraints];
    
}


@end
