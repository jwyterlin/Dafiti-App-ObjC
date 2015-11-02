//
//  JWNetAPIClient.h
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPSessionManager.h"

@interface JWNetAPIClient : AFHTTPSessionManager

+(instancetype)sharedClient;

@end
