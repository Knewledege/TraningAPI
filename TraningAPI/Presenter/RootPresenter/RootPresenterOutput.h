//
//  RootPresenterOutput.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#ifndef RootPresenterOutput_h
#define RootPresenterOutput_h


#endif /* RootPresenterOutput_h */
#import "StoryBoard.h"
@protocol RootPresenterOutput <NSObject>
@required
- (void)performChild: (int)to;
- (void)toggleIsHidden;
@end
