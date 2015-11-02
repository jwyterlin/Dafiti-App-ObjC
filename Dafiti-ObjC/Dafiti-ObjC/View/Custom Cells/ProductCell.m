//
//  ProductCell.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ProductCell.h"

@interface ProductCell()

@property(weak,nonatomic) IBOutlet UIImageView *photo;
@property(weak,nonatomic) IBOutlet UILabel *name;
@property(weak,nonatomic) IBOutlet UILabel *manufacturer;
@property(weak,nonatomic) IBOutlet UILabel *price;

@end

@implementation ProductCell

-(void)awakeFromNib {
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Public methods

-(ProductCell *)productCellAtIndexPath:(NSIndexPath *)indexPath
                             tableView:(UITableView *)tableView
                               product:(ProductModel *)product {
    
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:kNibNameProductCell forIndexPath:indexPath];
    [self configureProductCell:cell product:product];
    
    return cell;
    
}

-(void)configureProductCell:(ProductCell *)cell
                    product:(ProductModel *)product {
    
    if ( product == nil ) {
        
        cell.name.text = @"";
        
        return;
        
    }
    
    cell.name.text = product.name;
    
}


@end
