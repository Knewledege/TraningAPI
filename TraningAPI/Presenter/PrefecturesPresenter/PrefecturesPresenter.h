//
//  PrefecturesPresenter.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#ifndef PrefecturesPresenter_h
#define PrefecturesPresenter_h


#endif /* PrefecturesPresenter_h */
#import <Foundation/Foundation.h>
#import "PrefecturesView.h"
#import "PrefecturesPresenterInput.h"
#import "PrefecturesInput.h"
#import "PrefecturesUseCase.h"

@interface PrefecturesPresenter : NSObject <PrefecturesPresenterInput>
@property (weak, nonatomic) id<PrefecturesView> delegate;
@property (nonatomic) id<PrefecturesInput> model;
- (instancetype)initWithViewControllerDelegate: (id<PrefecturesView>)delegate;
@end
