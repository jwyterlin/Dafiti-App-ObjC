//
//  UITableView+Helper.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Helper)

-(void)registerNibForCellReuseIdentifier:(NSString *)identifier;

-(void)removeSeparator;

@end
