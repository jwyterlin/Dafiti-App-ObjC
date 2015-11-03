//
//  CellHelper.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CellHelperDelegate;

@interface CellHelper : NSObject {
    id <CellHelperDelegate> delegate;
}

/*!
 * @brief Object to be the delegate of the class CellHelper
 */
@property (nonatomic,strong) id <CellHelperDelegate> delegate;

-(CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell;

-(CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath
                         tableView:(UITableView *)tableView
                    cellIdentifier:(NSString *)cellIdentifier
                          delegate:(id)__delegate;

@end

@protocol CellHelperDelegate <NSObject>

@required

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
