//
//  ImageService.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericService.h"

@interface ImageService : GenericService

-(void)imageByUrl:(NSString *)url completion:(void(^)(UIImage *image))completion;

@end
