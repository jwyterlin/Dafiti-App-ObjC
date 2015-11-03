//
//  ImageCell.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 03/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ImageCell.h"

// Service
#import "ImageService.h"

@interface ImageCell()

@property(weak,nonatomic) IBOutlet UIImageView *image;
@property(weak,nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end

@implementation ImageCell

-(void)awakeFromNib {
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Public methods

-(ImageCell *)imageCellAtIndexPath:(NSIndexPath *)indexPath
                         tableView:(UITableView *)tableView
                           product:(ProductModel *)product {
    
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kNibNameImageCell forIndexPath:indexPath];
    [self configureImageCell:cell tableView:tableView indexPath:indexPath product:product];
    
    return cell;
    
}

-(void)configureImageCell:(ImageCell *)cell
                tableView:(UITableView *)tableView
                indexPath:(NSIndexPath *)indexPath
                  product:(ProductModel *)product {
    
    if ( product == nil ) {
        
        cell.image.image = nil;
        
        return;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    [cell defineUserPhotoWithProduct:product tableView:tableView indexPath:indexPath cell:cell];
    
}

#pragma mark - Private methods

-(void)defineUserPhotoWithProduct:(ProductModel *)product
                        tableView:(UITableView *)tableView
                        indexPath:(NSIndexPath *)indexPath
                             cell:(ImageCell *)cell {
    
    if ( product.largeFrontImage ) {
        
        cell.image.image = [UIImage imageWithData:product.largeFrontImage];
        return ;
        
    }
    
    if ( product.image )
        cell.image.image = [UIImage imageWithData:product.image];
    else
        cell.image.image = nil;
    
    if ( [Validator isEmptyString:product.largeFrontImageUrl] )
        return;
    
    if ( ! product.image )
        [cell.loading startAnimating];

    [[ImageService new] imageByUrl:product.largeFrontImageUrl completion:^(UIImage *image) {
        
        [cell.loading stopAnimating];
        
        ImageCell *helperCell = (ImageCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        if ( helperCell ) {
            
            if ( image ) {
                
                product.largeFrontImage = UIImageJPEGRepresentation(image, 1.0);
                helperCell.image.image = image;
                
            }
            
        }
        
    }];
    
}

@end
