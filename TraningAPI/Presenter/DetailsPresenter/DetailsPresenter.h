//
//  DetailsPresenter.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#ifndef DetailsPresenter_h
#define DetailsPresenter_h


#endif /* DetailsPresenter_h */
#import <Foundation/Foundation.h>
#import "DetailsPresenter.h"
#import "DetailsPresenterInput.h"
#import "DetailsPresenterOutput.h"
#import "PrefecturesUseCase.h"
@interface DetailsPresenter : NSObject <DetailsPresenterInput>
@property (weak, nonatomic) id <DetailsPresenterOutput> delegate;
@property (atomic) id <PrefecturesInput> model;
- (instancetype)initWithViewControllerDelegate:(id<DetailsPresenterOutput>)delegate;
@end
