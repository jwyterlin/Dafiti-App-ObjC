//
//  Routes.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "Routes.h"

@implementation Routes

+(NSString *)BASE_URL {
    return @"http://server.com/";
}

+(NSString *)BASE_URL_API {
    return [NSString stringWithFormat:@"%@",[Routes BASE_URL]];
}

+(NSString *)WS_TEST {
    return @"TEST";
}

@end
