//
//  PrefecturesInput.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/19.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#ifndef PrefecturesInput_h
#define PrefecturesInput_h


#endif /* PrefecturesInput_h */
#import <Foundation/Foundation.h>
#import "PrefecturesEntity.h"
#import <PromiseKit/PromiseKit.h>

/*ユースケース アクセスプロトコル*/
@protocol PrefecturesInput <NSObject>
@required
/// 全都道府県データ取得
- (AnyPromise *)getPregectures: (BOOL)executionRequest;
/// 各都道府県データ取得
- (void)getDetails: (int)idNumber;
// 全都道府県データ
@property NSArray<Prefectures *> *prefectures;
// 指定都道府県データ
@property Prefectures *details;
@end
