//
//  ImageCell.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 03/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericCell.h"

@interface ImageCell : GenericCell

-(ImageCell *)imageCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

@end
