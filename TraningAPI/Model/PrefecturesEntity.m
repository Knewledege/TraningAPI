//
//  PrefecturesEntity.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/19.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import "PrefecturesEntity.h"
#import "Common.h"
@implementation Prefectures
+ (NSString *)primaryKey {
    return @"id";
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _id = [[dictionary objectForKey:@"id"] integerValue];
        _name = [dictionary objectForKey:@"name_ja"];
        _population = [[dictionary objectForKey:@"population"] integerValue];
        _cases = [[dictionary objectForKey:@"cases"] integerValue];
        _deaths = [[dictionary objectForKey:@"deaths"] integerValue];
        _pcr = [[dictionary objectForKey:@"pcr"] integerValue];
        _hospitalize = [[dictionary objectForKey:@"hospitalize"] integerValue];
        _severe = [[dictionary objectForKey:@"severe"] integerValue];
        _discharge = [[dictionary objectForKey:@"discharge"] integerValue];
        _symptomConfirming = [[dictionary objectForKey:@"symptom_confirming"] integerValue];
        NSDictionary* dicLastUpdate = [dictionary valueForKey:@"last_updated"];
        _lastUpdated = [[LastUpdated alloc] initWithDictionary:dicLastUpdate];
        _updated = [NSDate date];
    }
    return self;
}

@end

@implementation LastUpdated
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _casesDate = [[dictionary objectForKey:@"cases_date"] integerValue];
        _deathsDate = [[dictionary objectForKey:@"deaths_date"] integerValue];
        _pcrDate = [[dictionary objectForKey:@"pcr_date"] integerValue];
        _hospitalizeDate = [[dictionary objectForKey:@"hospitalize_date"] integerValue];
        _severeDate = [[dictionary objectForKey:@"severe_date"] integerValue];
        _dischargeDate = [[dictionary objectForKey:@"discharge_date"] integerValue];
        _symptomConfirmingDate = [[dictionary objectForKey:@"symptom_confirming_date"] integerValue];
    }
    return self;
}

@end
// jsonデータをprefecturesクラスのプロパティに格納
@implementation DecodePrefectures
+ (NSArray<Prefectures *> *)jsonDecode:(id)data {
    NSMutableArray *decodePrefectures = [[NSMutableArray alloc] init];
    for (NSDictionary *object in data) {
        Prefectures *prefectures = [[Prefectures alloc] initWithDictionary:object];
        [decodePrefectures addObject:prefectures];
    }
    NSArray<Prefectures *> *result = decodePrefectures;
    return result;
}

@end

// リージョンクラス
@implementation RegionModel
- (id)init {
    self = [super init];
    if (self) {
        // リージョン生成
        self.region = [[NSArray alloc] initWithObjects:@"北海道", @"東北", @"関東", @"中部", @"近畿", @"中国", @"四国", @"九州", nil];
        // 各リージョンのアコーディオン表示・非表示設定
        self.nameIsHidden = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithBool: false],//北海道
                             [NSNumber numberWithBool: false],//東北
                             [NSNumber numberWithBool: false],//関東
                             [NSNumber numberWithBool: false],//中部
                             [NSNumber numberWithBool: false],//近畿
                             [NSNumber numberWithBool: false],//中国
                             [NSNumber numberWithBool: false],//四国
                             [NSNumber numberWithBool: false],//九州
                             nil];
        // 各リージョンが持つ都道府県のID
        self.prefecturesID = [NSMutableArray arrayWithObjects:
                              @[@0],//北海道
                              @[@1,@2,@3,@4,@5,@6],//東北
                              @[@7,@8,@9,@10,@11,@12,@13],//関東
                              @[@14,@15,@16,@17,@18,@19,@20,@21,@22],//中部
                              @[@23,@24,@25,@26,@27,@28],//近畿
                              @[@29,@30,@31,@32,@33,@34],//中国
                              @[@35,@36,@37,@38],//四国
                              @[@39,@40,@41,@42,@43,@44,@45,@46],//九州
                              nil];
    }
    return self;
}

@end

@implementation Details
// prefecturesクラスのプロパティをDetailsViewControllerで扱いやすい配列に変換
+ (NSArray *)detailsToArray:(Prefectures *)prefectures {
    NSArray *tempDetails = [NSArray arrayWithObjects:
                            // 感染者数
                            @[CASES, [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.cases], [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.lastUpdated.casesDate]],
                            // 死者数
                            @[DEATHS, [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.deaths], [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.lastUpdated.deathsDate]],
                            // PCR検査数
                            @[PCR, [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.pcr], [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.lastUpdated.pcrDate]],
                            // 入院者数
                            @[HOSPITALIZE, [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.hospitalize], [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.lastUpdated.hospitalizeDate]],
                            // 重傷者数
                            @[SEVERE, [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.severe], [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.lastUpdated.severeDate]],
                            // 退院者数
                            @[DISCHARGE, [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.discharge], [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.lastUpdated.dischargeDate]],
                            // 自覚症状者数
                            @[SYMPTOMCONFIRMING, [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.symptomConfirming], [[NSString alloc] initWithFormat:@"%ld", (long)prefectures.lastUpdated.symptomConfirmingDate]],
                            nil];
    return tempDetails;
}
@end
