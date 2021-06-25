//
//  StoryBoard.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//


#ifndef StoryBoard_h
#define StoryBoard_h

#define Identifer(Board) [@[ @"PrefecturesListViewController", @"DetailsViewController", @"MenuViewController", @"LicenceListViewController", @"LicenceContentViewController"]  objectAtIndex:Board]
#endif /* StoryBoard_h */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class PrefecturesListViewController;
@class DetailsViewController;
@class MenuViewController;
@class LicenceListViewController;
@class LicenceContentViewController;

@interface StoryBoard : NSObject
typedef NS_ENUM(NSInteger, Board) {
    prefecturesList = 0,
    details,
    menuView,
    licenceList,
    licenceContent
};
+ (PrefecturesListViewController *)performPrefecturesListView: (UIViewController *)from;
+ (DetailsViewController *)performDetailsView: (UIViewController *)from prefecturesID:(int)idNumber;
+ (MenuViewController *)performMenuView: (UIViewController *)from;
+ (LicenceListViewController *)performLicenceListView: (UIViewController *)from;
+ (LicenceContentViewController *)performLicenceContentView: (UIViewController *)form licencesID:(int)idNumber;
+ (void)push:(UIViewController *)from toViewController:(UIViewController *)to;
@end
