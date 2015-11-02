//
//  GenericService.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <Foundation/Foundation.h>

// Service Layer
#import "Connection.h"
#import "Constants.h"
#import "Routes.h"

@interface GenericService : NSObject

-(NSString *)queryWithParameters:(NSDictionary *)parameters;
-(NSString *)showParameters:(NSArray *)parameters;

@end
