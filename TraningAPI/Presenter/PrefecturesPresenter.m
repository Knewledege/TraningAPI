//
//  PrefecturesPresenter.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrefecturesPresenter.h"
@implementation PrefecturesPresenter
@synthesize numberOfPrefectures;
- (instancetype)initWithViewControllerDelegate:(id<PrefecturesView>)delegate {
    self = [self init];
    if (self) {
        self.delegate = delegate;
        self.model = [[PrefecturesUseCase alloc] init];
    }
    return self;
}
/// 都道府県情報取得
- (void)getPrefecturesModel:(BOOL)updateComp {
    // 全都道府県中方取得
    [self.model getPregectures:updateComp].then (^(NSArray<Prefectures *> *prefectures){
        // テーブルビュー更新
        [self.delegate setList];
        
        // 最終更新日ラベル設定
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
        NSString *lastUpdate= [formatter stringFromDate:prefectures.firstObject.updated];
        [self.delegate setLastUpdate:lastUpdate];
    }).catch(^(NSError *error){
        [self.delegate alert:error];
    });
}
/// 都道府県名取得
- (NSString *)getPrefectureName:(int)index {
    NSString *defaultName = @"";
    if (self.model.prefectures.count > 0) {
        return self.model.prefectures[index].name;
    } else {
      return defaultName;
    }
}
/// 都道府県感染者数取得
- (NSString *)getCasesNumber:(int)index {
    NSString *defaultNumber = @"";
    if (self.model.prefectures.count > 0) {
        return [[NSString alloc] initWithFormat:@"%ld", (long)self.model.prefectures[index].cases];
    } else {
      return defaultNumber;
    }
}
@end
