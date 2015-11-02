//
//  ProductCell.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ProductCell.h"

// Service
#import "ImageService.h"

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
    [self configureProductCell:cell tableView:tableView indexPath:indexPath product:product];
    
    return cell;
    
}

-(void)configureProductCell:(ProductCell *)cell
                  tableView:(UITableView *)tableView
                  indexPath:(NSIndexPath *)indexPath
                    product:(ProductModel *)product {
    
    if ( product == nil ) {
        
        cell.name.text = @"";
        
        return;
        
    }
    
    cell.name.text = product.name;
    cell.manufacturer.text = product.manufacturer;
    cell.price.text = [NSString stringWithFormat:@"$ %.2f", [product.salePrice doubleValue]];
    
    [cell defineUserPhotoWithProduct:product tableView:tableView indexPath:indexPath cell:cell];
    
}

#pragma mark - Private methods

-(void)defineUserPhotoWithProduct:(ProductModel *)product
                      tableView:(UITableView *)tableView
                      indexPath:(NSIndexPath *)indexPath
                      cell:(ProductCell *)cell {
    
    if ( product.image ) {
        
        cell.photo.image = [UIImage imageWithData:product.image];
        return ;
        
    }
    
    cell.photo.image = nil;
    
    [[ImageService new] imageByUrl:product.imageUrl completion:^(UIImage *image) {
        
        ProductCell *helperCell = (ProductCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        if ( helperCell ) {
            
            if ( image ) {
                
                product.image = UIImageJPEGRepresentation(image, 1.0);
                helperCell.photo.image = image;
                
            }
            
        }
        
    }];
    
}

@end
