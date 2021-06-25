//
//  PrefecturesEntity.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/19.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#ifndef PrefecturesEntity_h
#define PrefecturesEntity_h

#endif /* PrefecturesEntity_h */
#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
@class LastUpdated;

// 都道府県クラス
@interface Prefectures: RLMObject
@property NSInteger id;
@property NSString *name;
@property NSInteger population;
@property NSInteger cases;
@property NSInteger deaths;
@property NSInteger pcr;
@property NSInteger hospitalize;
@property NSInteger severe;
@property NSInteger discharge;
@property NSInteger symptomConfirming;
@property LastUpdated *lastUpdated;
@property NSDate *updated;
- (instancetype)initWithDictionary: (NSDictionary *)dictionary;

@end
RLM_ARRAY_TYPE(Prefectures)

@interface LastUpdated : RLMObject
@property NSInteger casesDate;
@property NSInteger deathsDate;
@property NSInteger pcrDate;
@property NSInteger hospitalizeDate;
@property NSInteger severeDate;
@property NSInteger dischargeDate;
@property NSInteger symptomConfirmingDate;
- (instancetype)initWithDictionary: (NSDictionary *)dictionary;
@end

@interface DecodePrefectures : NSObject
// jsonデータをプロパティに格納
+ (NSArray<Prefectures *> *)jsonDecode: (id)data;
@end

// リージョンクラス
@interface RegionModel : NSObject
@property (nonatomic) NSArray<NSString *> *region;
@property (nonatomic) NSArray<NSNumber *> *nameIsHidden;
@property (nonatomic) NSMutableArray *prefecturesID;
- (id)init;
@end

@interface Details : NSObject
// prefectureのプロパティをViewで扱いやすい形の配列に変換
+ (NSArray *)detailsToArray: (Prefectures *)prefectures;
@end
