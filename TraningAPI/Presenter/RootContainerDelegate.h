//
//  RootContainerDelegate.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#ifndef RootContainerDelegate_h
#define RootContainerDelegate_h


#endif /* RootContainerDelegate_h */
@protocol RootContainerDelegate
@required
- (void)setMenuID:(int)listIndex;
- (void)viewWillAppear;
@end
