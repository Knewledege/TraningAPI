//
//  DetailsPresenter.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailsPresenter.h"
@implementation DetailsPresenter
- (instancetype)initWithViewControllerDelegate:(id <DetailsPresenterOutput>)delegate {
    self = [self init];
    if (self) {
        self.delegate = delegate;
        self.model = [[PrefecturesUseCase alloc] init];
    }
    return self;
}
/// 都道府県情報取得
- (void)getPrefecturesInfo:(int)idNumber {
    // idNumberで指定した都道府県情報取得
    [self.model getDetails:idNumber];
    // Viewで感染情報を扱いやすいように配列に変換
    NSArray<NSString *> *details = [Details detailsToArray:self.model.details];
    // 感染情報表示指示
    [self.delegate setContent:details];
    // 都道府県タイトルビュー設定
    [self.delegate setTitle:self.model.details.name population:[[NSString alloc] initWithFormat:@"%ld", (long)self.model.details.population]];
}

@end
