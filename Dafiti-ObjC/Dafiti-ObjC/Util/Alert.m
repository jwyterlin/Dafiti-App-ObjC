//
//  Alert.m
//  Dafiti-ObjC
//
//  Created by Jhonathan Wyterlin on 02/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "Alert.h"

@implementation Alert

-(UIAlertController *)showAlertMessage:(NSString *)message viewController:(UIViewController *)viewController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   [viewController dismissViewControllerAnimated:YES completion:nil];
                                               }];
    
    [alert addAction:ok];
    
    [viewController presentViewController:alert animated:YES completion:nil];
    
    return alert;
    
}

-(void)showError:(NSError *)error viewController:(UIViewController *)viewController {
    
    NSString *message = [NSString stringWithFormat:@"An error has occurred: %@\n\nFeel free to inform us about it via e-mail contact@mail.com.br.",error.localizedDescription];
    
    [self showAlertMessage:message viewController:viewController];
    
}

-(void)showNoConnectionWithViewController:(UIViewController *)viewController {
    [self showAlertMessage:@"No connection with internet" viewController:viewController];
}

@end
