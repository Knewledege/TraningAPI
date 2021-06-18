//
//  PrefecturesUseCase.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/18.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#ifndef PrefecturesUseCase_h
#define PrefecturesUseCase_h


#endif /* PrefecturesUseCase_h */
#import <Foundation/Foundation.h>
#import <TraningAPI-Swift.h>
#import <PromiseKit/PromiseKit.h>
@class Prefectures;
@class GithubAPI;
@class RealmDB;
@protocol PrefecturesInput;

@interface PrefecturesUseCase : NSObject <PrefecturesInput>
@property (nonatomic) NSArray<Prefectures *> *prefectures;
@property (nonatomic) Prefectures *details;
@property (nonatomic) GithubAPI *api;
@property (nonatomic) RealmDB *realmDB;
- (id)init;
- (AnyPromise *)getPregectures: (Boolean *)executionRequest;
- (Boolean *)getLastUpdate: (NSData *)updated;
- (void)getDetails: (int)idNumber;
@end
