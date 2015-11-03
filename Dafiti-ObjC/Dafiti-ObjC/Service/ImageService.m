//
//  ImageService.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ImageService.h"

@implementation ImageService

#pragma mark - Public methods

-(void)imageByUrl:(NSString *)url completion:(void(^)(UIImage *image))completion {
    
    NSURL *imageURL = [NSURL URLWithString:url];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        if (completion) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
            
        }
        
    });
    
}

-(void)saveImageById:(id)identifier photo:(NSData *)data folderName:(NSString *)folderName fileName:(NSString*)fileName {
    
    NSString *filePath = [self getPhotoPathForUserId:identifier folderName:folderName withFileName:fileName];
    
    if ( [data length] > 0 ) {
        
        // Delete image, if exists
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
        }
        
        // Storing image
        [data writeToFile:filePath atomically:YES];
        
    }
    
}

-(UIImage *)seekImageLocallyById:(id)identifier folderName:(NSString *)folderName filename:(id)filename {
    
    if ( filename == NULL || filename == [NSNull null] )
        return NULL;
    
    if ( [filename isEqualToString:@""] )
        return NULL;
    
    NSString *filePath = [self getPhotoPathForUserId:identifier folderName:folderName withFileName:filename];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    if ( fileExists ) {
        
        // Image exists
        return [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:filePath]];
        
    } else {
        // Image doesn't exist
        return NULL;
        
    }
    
}

#pragma mark - Private methods

-(NSString *)getPhotoPathForUserId:(id)identifier folderName:(NSString *)folderName withFileName:(NSString *)fileName {
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folder = [NSString stringWithFormat:@"%@/%@/%@/",docDir, kCachedImages,folderName];
    
    BOOL folderExists = [[NSFileManager defaultManager] fileExistsAtPath:folder];
    
    if ( ! folderExists ) {
        if ( ! [[NSFileManager defaultManager] createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:NULL] )
            NSLog( @"Error: Create folder failed %@", docDir );
    }
    
    NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@/%@/%@.%@", docDir, kCachedImages, folderName, identifier, [fileName pathExtension]];
    
    return pngFilePath;
    
}



@end
