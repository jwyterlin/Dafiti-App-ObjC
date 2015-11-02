//
//  ProductService.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ProductService.h"

#import "AFHTTPSessionManager.h"

@implementation ProductService

/*
 *  Request:
 *
 *  http://api.bestbuy.com/v1/products(longDescription=iPhone*|sku=7619002)?show=sku,name&pageSize=15&page=5&apiKey=YourAPIKey&format=json
 *
 */

-(void)productsListWithTerm:(NSString *)term
                       page:(NSNumber *)page
                      limit:(NSNumber *)limit
                 completion:(void(^)(NSArray *products, BOOL hasNoConnection, NSError *error))completion {
    
    [self productsListWithTerm:term page:page limit:limit completion:^(NSArray *products, BOOL hasNoConnection, NSError *error) {
        if ( completion ) {
            completion( products, hasNoConnection, error );
        }
    } test:^(id responseData, NSError *error) {
        // Do nothing
    }];
    
}

-(void)productsListWithTerm:(NSString *)term
                       page:(NSNumber *)page
                      limit:(NSNumber *)limit
                 completion:(void(^)(NSArray *products, BOOL hasNoConnection, NSError *error))completion
                    test:(void(^)(id responseData, NSError *error))test {
    
    if ( ! term ) {
        
        NSError *error = [NSError errorWithDomain:kAppDomain code:420 userInfo:@{NSLocalizedDescriptionKey:@"Term is required"}];
        
        if ( completion )
            completion( nil, NO, error );
        return;
        
    }
    
    if ( ! page ) {
        
        NSError *error = [NSError errorWithDomain:kAppDomain code:420 userInfo:@{NSLocalizedDescriptionKey:@"Page is required"}];
        
        if ( completion )
            completion( nil, NO, error );
        return;
        
    }
    
    if ( ! limit ) {
        
        NSError *error = [NSError errorWithDomain:kAppDomain code:420 userInfo:@{NSLocalizedDescriptionKey:@"Limit is required"}];
        
        if ( completion )
            completion( nil, NO, error );
        return;
        
    }
    
    NSDictionary *queryParameters = @{
                                      kParameterName:[NSString stringWithFormat:@"%@*",term]
                                    };
    
    NSString *query = [self queryWithParameters:queryParameters];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[Routes WS_PRODUCTS],query];
    
    NSArray *show = @[
                      @"name",
                      @"longDescription",
                      @"manufacturer",
                      @"salePrice",
                      @"image",
                      @"largeFrontImage"
                     ];
    
    NSDictionary *parameters = @{
                                 kParameterShow:[self showParameters:show],
                                 kParameterPageSize:limit,
                                 kParameterPage:page
                                };

    [[Connection new] connectWithMethod:RequestMethodGet requestSerializer:RequestSerializerJSON url:url parameters:parameters success:^(id responseData) {
        
        if ( test )
            test( responseData, nil );
        
        NSDictionary *result = (NSDictionary *)responseData;
        
        if (completion)
            completion(nil,NO,nil);
        
    } failure:^(BOOL hasNoConnection, NSError *error) {
        
        if ( test )
            test( nil, error );
        
        if (completion)
            completion(nil,hasNoConnection,error);
        
    }];
    
}

-(void)foo {
    
    
    
}

@end
