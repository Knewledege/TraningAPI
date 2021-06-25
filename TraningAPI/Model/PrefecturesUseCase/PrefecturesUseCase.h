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
#import <PromiseKit/PromiseKit.h>
#import <AnyPromise.h>
#import <Reachability.h>
#import "PrefecturesInput.h"
#import "GithubAPI.h"
#import "RealmDB.h"

@interface PrefecturesUseCase : NSObject <PrefecturesInput>
@property (nonatomic) GithubAPI *api;
@property (nonatomic) RealmDB *realmDB;
@property (nonatomic) Reachability *reachability;
- (BOOL)getLastUpdate: (NSDate *)updated;
@end
