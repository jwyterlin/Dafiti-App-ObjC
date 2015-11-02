//
//  Connection.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "Connection.h"
#import "Constants.h"
#import "JWNetAPIClient.h"
#import "Reachability.h"
#import "Routes.h"

@interface Connection()<NSURLConnectionDelegate>

@property(nonatomic,strong) NSMutableData *responseData;
@property (copy) void (^blockProperty)(NSDictionary *response, BOOL hasNoConnection, NSError *error);

@end

@implementation Connection

// Complete request method to the WebService
-(void)connectWithMethod:(RequestMethod)method
                     url:(NSString *)url
              parameters:(NSDictionary *)parameters
                 success:(void (^)(id responseData))success
                 failure:(void (^)(BOOL hasNoConnection, NSError *error))failure {
    
    [self connectWithMethod:method requestSerializer:RequestSerializerHTTP url:url parameters:parameters  success:^(id responseData) {
        if (success)
            success(responseData);
    } failure:^(BOOL hasNoConnection, NSError *error) {
        if (failure)
            failure(hasNoConnection,error);
    }];
    
}

-(void)connectWithMethod:(RequestMethod)method
       requestSerializer:(RequestSerializer)requestSerializer
                     url:(NSString *)url
              parameters:(NSDictionary *)parameters
                 success:(void (^)(id responseData))success
                 failure:(void (^)(BOOL hasNoConnection, NSError *error))failure {
    
    if ( ! [self isNetworkReachable] ) {
        
        if (failure)
            failure(YES,nil);
        
        return;
        
    }
    
    // Set RequestSerializer
    if ( requestSerializer == RequestSerializerHTTP )
        [[JWNetAPIClient sharedClient] setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    else
        [[JWNetAPIClient sharedClient] setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    parameters = [self addFixedParametersWithParameters:parameters];
    
    
    if ( method == RequestMethodGet ) {
        
        // Sents the GET to server and capture response object, giving back callbacks to consumer.
        [[JWNetAPIClient sharedClient] GET:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success)
                success(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure)
                failure(NO, error);
        }];
        
    } else if ( method == RequestMethodPost ) {
        
        // Sents the POST to server and capture response object, giving back callbacks to consumer.
        [[JWNetAPIClient sharedClient] POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success)
                success(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure)
                failure(NO, error);
        }];
        
    } else if ( method == RequestMethodDelete ) {
        
        // Sents the DELETE to server and capture response object, giving back callbacks to consumer.
        [[JWNetAPIClient sharedClient] DELETE:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success)
                success(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure)
                failure(NO, error);
        }];
        
    } else if ( method == RequestMethodPut ) {
        
        // Sents the PUT to server and capture response object, giving back callbacks to consumer.
        [[JWNetAPIClient sharedClient] PUT:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success)
                success(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure)
                failure(NO, error);
        }];
        
    }
    
}

#pragma mark - Private methods

-(BOOL)isNetworkReachable {
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    if ( networkStatus == NotReachable || [reachability connectionRequired] )
        return NO;
    else
        return YES;
    
}

-(NSDictionary *)addFixedParametersWithParameters:(NSDictionary *)parameters {
    
    NSMutableDictionary *params;
    
    if ( parameters == nil )
        params = [NSMutableDictionary new];
    else
        params = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    
    [params setObject:kBestBuyAPIKey forKey:@"apiKey"];
    [params setObject:@"json" forKey:@"format"];
    
    return [params mutableCopy];
    
}

@end
