//
//  StoryBoard.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoryBoard.h"
#import "PrefecturesListViewController.h"
#import "DetailsViewController.h"
#import "MenuViewController.h"
#import "LicenceListViewController.h"
#import "LicenceContentViewController.h"
@implementation StoryBoard
+ (PrefecturesListViewController *)performPrefecturesListView: (UIViewController *)from {
    Board view = prefecturesList;
    NSString *identifer = Identifer(view);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PrefecturesListViewController *nextVC = [storyboard instantiateViewControllerWithIdentifier: identifer];
    return nextVC;
}
+ (DetailsViewController *)performDetailsView: (UIViewController *)from prefecturesID:(int)idNumber {
    Board view = details;
    NSString *identifer = Identifer(view);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsViewController *nextVC = [storyboard instantiateViewControllerWithIdentifier: identifer];
    nextVC.idNumber = idNumber;
    return nextVC;
}
+ (MenuViewController *)performMenuView: (UIViewController *)from {
    Board view = menuView;
    NSString *identifer = Identifer(view);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MenuViewController *nextVC = [storyboard instantiateViewControllerWithIdentifier: identifer];
    return nextVC;
}
+ (LicenceListViewController *)performLicenceListView: (UIViewController *)from {
    LicenceListViewController *nextVC = [[LicenceListViewController alloc] init];
    return nextVC;
}
+ (LicenceContentViewController *)performLicenceContentView: (UIViewController *)form licencesID:(int)idNumber {
    LicenceContentViewController *nextVC = [[LicenceContentViewController alloc] init];
    nextVC.titles = Common.libraryTitle[idNumber];
    nextVC.content = Common.libraryContent[idNumber];
    return nextVC;
}
+ (void)push:(UIViewController *)from toViewController:(UIViewController *)to {
    [from.navigationController pushViewController:to animated:true ];
}
@end
