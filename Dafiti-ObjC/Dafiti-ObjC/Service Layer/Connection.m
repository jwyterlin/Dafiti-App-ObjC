//
//  Connection.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "Connection.h"
#import "JWNetAPIClient.h"
#import "Reachability.h"
#import "Routes.h"

@interface Connection()<NSURLConnectionDelegate>

@property(nonatomic,strong) NSMutableData *responseData;
@property (copy) void (^blockProperty)(NSDictionary *response, BOOL hasNoConnection, NSError *error);

@end

@implementation Connection

-(void)connectWithParameters:(NSDictionary *)parameters
                  completion:(void(^)(NSDictionary *response, BOOL hasNoConnection, NSError *error))completion {
    
    if ( ! [self isNetworkReachable] ) {
        
        if (completion)
            completion(nil, YES, nil);
        
        return;
        
    }
    
    NSString *url = [self urlFromParameters:parameters];
    
    url = [NSString stringWithFormat:@"%@%@",[Routes BASE_URL_API],url];
    
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // Specify that it will be a GET request
    request.HTTPMethod = @"GET";
    
    // Header fields
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (completion)
        self.blockProperty = completion;
    
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData = [NSMutableData new];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the responseData
    [self.responseData appendData:data];
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection
                 willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError *jsonError;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:self.responseData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    self.blockProperty(json,NO,jsonError);
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.blockProperty(nil,NO,error);
}

#pragma mark -

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
    if ( requestSerializer == RequestSerializerHTTP ) {
        [[JWNetAPIClient sharedClient] setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    } else {
        [[JWNetAPIClient sharedClient] setRequestSerializer:[AFJSONRequestSerializer serializer]];
    }
    
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

-(NSString *)urlFromParameters:(NSDictionary *)parameters {
    
    NSMutableString *url = [NSMutableString new];
    
    [url appendString:@"?"];
    
    for ( NSString *key in parameters.allKeys ) {
        [url appendFormat:@"%@", key];
        [url appendString:@"="];
        [url appendFormat:@"%@", parameters[key]];
        [url appendString:@"&"];
    }
    
    NSString *urlConverted = [url substringWithRange:NSMakeRange(0, url.length-1)];
    
    return urlConverted;
    
}

@end
