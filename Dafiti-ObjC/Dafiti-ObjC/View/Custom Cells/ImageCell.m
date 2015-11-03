//
//  ImageCell.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 03/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell()

@property(weak,nonatomic) IBOutlet UIImageView *image;

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
    
    cell.image.image = [UIImage imageWithData:product.image];
    
}

@end
