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

@end
