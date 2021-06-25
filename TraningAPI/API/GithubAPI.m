//
//  GithubAPI.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/18.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GithubAPI.h"

@implementation GithubAPI : NSObject
- (AnyPromise *)prefecturesAPI {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        NSString *url = @"https://covid19-japan-web-api.vercel.app/api/v1/prefectures";
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionTask *task, id response) {
            // json取得に成功した場合
            resolve(response);
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            // エラーの場合
            resolve(error);
        }];
    }];
}
@end
