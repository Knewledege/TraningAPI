//
//  Common.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/19.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

/* アプリ全体で使用する変数や値を宣言 */

#ifndef Common_h
#define Common_h
#define ITEMNAME @"項目"
#define PERSONS @"人数"
#define LASTUPDATE @"最終更新日"
#define POPULATION @"人口："
#define CASES @"感染者数"
#define DEATHS @"死者数"
#define PCR @"PCR検査数"
#define HOSPITALIZE @"入院者数"
#define SEVERE @"重症者数"
#define DISCHARGE @"退院者数"
#define SYMPTOMCONFIRMING @"自覚症状者数"
#endif /* Common_h */
@interface Common : NSObject
/* ViewのUILabelに使う文字列 */
+ (NSString *_Nonnull)casesTitle;
+ (NSString *_Nonnull)titleLabelText;
+ (NSString *_Nonnull)numberLabelText;
+ (NSString *_Nonnull)updatedLabelText;
/* ナビゲーションのタイトル */
+ (NSString *_Nonnull)licenceTitle;
+ (NSArray<NSString *> *_Nonnull)libraryTitle;
/* ライセンス表記 */
+ (NSString *_Nonnull)promisekitLicence;
+ (NSString *_Nonnull)afnetworkingLicence;
+ (NSString *_Nonnull)realmLicence;
// ライセンス名格納配列
+ (NSArray<NSString *> *_Nonnull)libraryContent;
// メニューバー表示リスト
+ (NSArray<NSString *> *_Nonnull)menuList;

@end
