//
//  PrefecturesPresenterInput.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#ifndef PrefecturesPresenterInput_h
#define PrefecturesPresenterInput_h


#endif /* PrefecturesPresenterInput_h */
#import <Foundation/Foundation.h>
@protocol PrefecturesPresenterInput <NSObject>
@required
@property (nonatomic) int numberOfPrefectures;
- (void)getPrefecturesModel: (BOOL)updateComp;
- (NSString *)getPrefectureName: (int)index;
- (NSString *)getCasesNumber: (int) index;
@end
