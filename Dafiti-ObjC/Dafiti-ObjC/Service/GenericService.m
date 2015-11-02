//
//  GenericService.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericService.h"

@implementation GenericService

-(NSString *)queryWithParameters:(NSDictionary *)parameters {
    
    NSMutableString *query = [NSMutableString new];
    
    [query appendString:@"("];
    
    for ( NSString *key in parameters.allKeys ) {
        [query appendFormat:@"%@", key];
        [query appendString:@"="];
        [query appendFormat:@"%@", parameters[key]];
        [query appendString:kPipe];
    }
    
    NSString *queryConvertedToString = [query substringWithRange:NSMakeRange( 0, query.length-3 )];
    
    queryConvertedToString = [NSString stringWithFormat:@"%@)",queryConvertedToString];
    
    return queryConvertedToString;
    
}

-(NSString *)showParameters:(NSArray *)parameters {
    
    NSMutableString *showParameters = [NSMutableString new];
    
    for ( NSString *parameter in parameters ) {
        [showParameters appendFormat:@"%@", parameter];
        [showParameters appendString:@","];
    }
    
    NSString *showParametersConvertedToString = [showParameters substringWithRange:NSMakeRange( 0, showParameters.length-1 )];
    
    return showParametersConvertedToString;
    
}

@end
