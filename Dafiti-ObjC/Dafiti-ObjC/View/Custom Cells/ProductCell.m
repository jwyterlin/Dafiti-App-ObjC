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
@property(weak,nonatomic) IBOutlet CellLabel *name;
@property(weak,nonatomic) IBOutlet CellLabel *manufacturer;
@property(weak,nonatomic) IBOutlet UILabel *price;
@property(weak,nonatomic) IBOutlet UIActivityIndicatorView *loading;

@property(weak,nonatomic) IBOutlet NSLayoutConstraint *nameWidth;
@property(weak,nonatomic) IBOutlet NSLayoutConstraint *manufacturerWidth;
@property(weak,nonatomic) IBOutlet NSLayoutConstraint *priceWidth;

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
        cell.manufacturer.text = @"";
        cell.price.text = @"";
        
        return;
        
    }
    
    cell.name.text = product.name;
    cell.manufacturer.text = product.manufacturer;
    cell.price.text = [NSString stringWithFormat:@"$ %.2f", [product.salePrice doubleValue]];
    
    int rightWidth = tableView.width - cell.name.x - 8;
    
    if ( cell.nameWidth.constant != rightWidth ) {
    
        cell.nameWidth.constant = rightWidth;
        cell.manufacturerWidth.constant = rightWidth;
        cell.priceWidth.constant = rightWidth;
        
    }

    [cell.name setNeedsUpdateConstraints];
    [cell.manufacturer setNeedsUpdateConstraints];
    [cell.price setNeedsUpdateConstraints];
    
    [cell defineUserPhotoWithProduct:product tableView:tableView indexPath:indexPath cell:cell];
    
}

#pragma mark - Private methods

-(void)defineUserPhotoWithProduct:(ProductModel *)product
                      tableView:(UITableView *)tableView
                      indexPath:(NSIndexPath *)indexPath
                      cell:(ProductCell *)cell {
    
    // Already has image
    if ( product.image ) {
        
        cell.photo.image = [UIImage imageWithData:product.image];
        return ;
        
    }
    
    ImageService *imageService = [ImageService new];
    
    NSString *filename = [product.sku stringValue];
    NSString *identifier = [NSString stringWithFormat:@"%@%@",@"normal",[product.sku stringValue]];
    
    // Seek image locally
    UIImage *imageSought = [imageService seekImageLocallyById:identifier folderName:kParameterProducts filename:filename];
    
    if ( imageSought ) {
        
        product.image = UIImageJPEGRepresentation(imageSought, 1.0);
        cell.photo.image = [UIImage imageWithData:product.image];
        return ;
        
    }
    
    // Set to nil to avoid show wrong image of other cell
    cell.photo.image = nil;
    
    // If doesn't have imageUrl, doesn't download
    if ( [Validator isEmptyString:product.imageUrl] )
        return;
    
    // Download image
    [cell.loading startAnimating];
    
    [imageService imageByUrl:product.imageUrl completion:^(UIImage *image) {
        
        [cell.loading stopAnimating];
        
        ProductCell *helperCell = (ProductCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        if ( helperCell ) {
            
            if ( image ) {
                
                product.image = UIImageJPEGRepresentation(image, 1.0);
                helperCell.photo.image = image;
                
                [imageService saveImageById:identifier photo:product.image folderName:kParameterProducts fileName:filename];
                
            }
            
        }
        
    }];
    
}

@end
