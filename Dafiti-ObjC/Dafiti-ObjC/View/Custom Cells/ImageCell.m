//
//  ImageCell.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 03/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

-(void)awakeFromNib {
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Public methods

-(ImageCell *)imageCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kNibNameImageCell forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

@end
