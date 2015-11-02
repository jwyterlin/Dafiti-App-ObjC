//
//  ProductService.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericService.h"

@interface ProductService : GenericService

-(void)productsListWithTerm:(NSString *)term
                       page:(NSNumber *)page
                      limit:(NSNumber *)limit
                 completion:(void(^)(NSArray *products, BOOL hasNoConnection, NSError *error))completion;

-(void)productsListWithTerm:(NSString *)term
                       page:(NSNumber *)page
                      limit:(NSNumber *)limit
                 completion:(void(^)(NSArray *products, BOOL hasNoConnection, NSError *error))completion
                       test:(void(^)(id responseData, NSError *error))test;

@end
