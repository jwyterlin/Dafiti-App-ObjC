//
//  Connection.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Connection : NSObject

typedef enum {
    RequestMethodGet=0,
    RequestMethodPost,
    RequestMethodDelete,
    RequestMethodPut
} RequestMethod;

typedef enum {
    RequestSerializerHTTP=0,
    RequestSerializerJSON,
} RequestSerializer;

-(void)connectWithParameters:(NSDictionary *)parameters
                  completion:(void(^)(NSDictionary *response, BOOL hasNoConnection, NSError *error))completion;

// Complete request method to the WebService
-(void)connectWithMethod:(RequestMethod)method
                     url:(NSString *)url
              parameters:(NSDictionary *)parameters
                 success:(void (^)(id responseData))success
                 failure:(void (^)(BOOL hasNoConnection, NSError *error))failure;

-(void)connectWithMethod:(RequestMethod)method
       requestSerializer:(RequestSerializer)requestSerializer
                     url:(NSString *)url
              parameters:(NSDictionary *)parameters
                 success:(void (^)(id responseData))success
                 failure:(void (^)(BOOL hasNoConnection, NSError *error))failure;

@end
