//
//  RealmDB.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/18.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#ifndef RealmDB_h
#define RealmDB_h


#endif /* RealmDB_h */
#import <Realm/Realm.h>
@class Prefectures;

@interface RealmDB : NSObject
@property RLMRealm *realm;
+ (RealmDB *)sharedManager;
- (void)setPrefecturesOnRealmDB:(NSArray<Prefectures *> *)prefectures;
- (void)updatePrefecturesOnRealmDB:(NSArray<Prefectures *> *)prefectures;
- (NSArray<Prefectures *> *)getPrefecturesByRealmDB;
- (Prefectures *)getPrefecturesByID: (int)idNumber;
@end
