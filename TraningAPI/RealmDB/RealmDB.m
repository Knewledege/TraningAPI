//
//  RealmDB.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/18.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import "PrefecturesEntity.h"
#import "RealmDB.h"

@implementation RealmDB
static RealmDB *shared_ = nil;

+ (RealmDB *)sharedManager {
   @synchronized(self){
       if (!shared_) {
           shared_ = [RealmDB new];
       }
   }
   return shared_;
}

- (id)init
{
   self = [super init];
   if (self) {
       self.realm = [RLMRealm defaultRealm];
   }
   return self;
}
- (void)setPrefecturesOnRealmDB:(NSArray<Prefectures *> *)prefectures {
    [_realm beginWriteTransaction];
    [_realm addObjects: prefectures];
    [_realm commitWriteTransaction];
}
- (void)updatePrefecturesOnRealmDB:(NSArray<Prefectures *> *)prefectures {
    [_realm beginWriteTransaction];
    [_realm addOrUpdateObjects: prefectures];
    [_realm commitWriteTransaction];
}
- (NSArray<Prefectures *> *)getPrefecturesByRealmDB {
    RLMResults<Prefectures *> *result = [Prefectures allObjects];
    NSMutableArray *tempPrefectures = [NSMutableArray array];
    for (Prefectures *data in result) {
        [tempPrefectures addObject: data];
    }
    NSArray<Prefectures *> *prefectures = tempPrefectures;
    return prefectures;
}
- (Prefectures *)getPrefecturesByID: (int)idNubmer {
    id idObject = [NSNumber numberWithInt:idNubmer];
    Prefectures *result = [Prefectures objectInRealm: self.realm forPrimaryKey:idObject];
    return result;
}
@end
