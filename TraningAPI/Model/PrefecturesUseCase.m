//
//  PrefecturesUseCase.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/18.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrefecturesUseCase.h"
#import "PrefecturesEntity.h"

@implementation PrefecturesUseCase
@synthesize details;
@synthesize prefectures;

- (AnyPromise *)getPregectures:(BOOL)executionRequest {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        
        self.realmDB = [RealmDB sharedManager];
        self.reachability = [Reachability reachabilityForInternetConnection];
        // DBより全都道府県データ取得
        NSArray<Prefectures *> *dbResult = self.realmDB.getPrefecturesByRealmDB;

        // DBにデータが存在する場合
        if (dbResult.count > 0) {
            self.prefectures = dbResult;
            // 圏外ならDBの値を返す
            if (self.reachability.currentReachabilityStatus == NotReachable) {
                resolve(self.prefectures);
                return;
            }
            
            // 圏内且つ最終更新時間が1分以内でもDBの値を返す
            if ([self getLastUpdate:self.prefectures.firstObject.updated] ){
                resolve(self.prefectures);
                return;
            }
        }
        self.api = [[GithubAPI alloc] init];
        //DBに値がない場合かつ、最終更新時間が1分以上の場合はAPI叩く
        self.api.prefecturesAPI.then(^(id result) {
            // jsonデータをprefecturesクラスのプロパティに格納
            NSArray<Prefectures  *> *tempPrefectures =  [DecodePrefectures jsonDecode:result];
            self.prefectures = tempPrefectures;
            // 既にDBにデータがある場合
            if (dbResult.count > 0) {
                // 都道府県データを更新
                [self.realmDB updatePrefecturesOnRealmDB:tempPrefectures];
            } else {
            // DBにデータがない場合
                // 都道府県データを新規追加
                [self.realmDB setPrefecturesOnRealmDB:tempPrefectures];
            }
            resolve(self.prefectures);
        }).catch(^(NSError *error){
            resolve(error);
        });
        return;
    }];
    
}
- (BOOL)getLastUpdate: (NSDate *)updated {
    if (updated == nil) {
        return false;
    } else {
        // 現在時刻
        NSDate *now = [NSDate date];
        NSCalendar *calender = [NSCalendar currentCalendar];
        // 最終更新日と現在時刻を比較
        NSDateComponents *comps = [calender components:NSCalendarUnitDay fromDate:updated  toDate:now  options:0];
        // 1分以上の差がある場合
        if (comps.minute > 1) {
            return false;
        }
    }
    return true;
}
- (void)getDetails:(int)idNumber {
    self.realmDB = [RealmDB sharedManager];
    // idカラムにidNumberを指定しデータを取得
    self.details = [_realmDB getPrefecturesByID:idNumber];
}

@end
