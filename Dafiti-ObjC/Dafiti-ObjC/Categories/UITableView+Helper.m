//
//  UITableView+Helper.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "UITableView+Helper.h"

@implementation UITableView (Helper)

-(void)registerNibForCellReuseIdentifier:(NSString *)identifier {
    
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:identifier];
    
}

-(void)removeSeparator {
    self.separatorColor = [UIColor clearColor];
}

@end
