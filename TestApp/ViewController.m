//
//  ViewController.m
//  TestApp
//
//  Created by Blake Lucchesi on 6/10/15.
//  Copyright (c) 2015 Mattermark. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showShare:(id)sender {
    UIImage *shareImage = [UIImage imageNamed:@"ShareImage"];
    NSString *shareText = @"SomeText";
    NSArray *activityItems = @[shareImage];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    // NB: Used on iPad, check required for iOS 7 compatability.
//    if ([activityViewController respondsToSelector:@selector(popoverPresentationController)]) {
//        activityViewController.popoverPresentationController.view = self.navigationItem.rightBarButtonItem;
//    }
    
    // NB: Introduced in iOS 8.
    if ([activityViewController respondsToSelector:@selector(setCompletionWithItemsHandler:)]) {
        activityViewController.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
            NSLog(@"The selected activity was %@", activityType);
            if (completed) {
                NSLog(@"Activity action completed");
            }
            else {
                NSLog(@"Activity action not completed");
                if (activityError) {
                    NSLog(@"Activity Error: %@", activityError);
                }
            }
        };
    }
    else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        activityViewController.completionHandler = ^(NSString *activityType, BOOL completed) {
            // When sharing in iOS 7 completed doesn't update correctly, specifically airdrop shares don't
            // trigger _completed_ to get set to YES even though it was shared.
            if (activityType) {
                NSLog(@"The selected activity was %@", activityType);
            }
            else {
                NSLog(@"Activity action not completed");
            }
        };
#pragma GCC diagnostic pop
    }
    [self presentViewController:activityViewController animated:YES completion:^{
        
    }];
}

@end
