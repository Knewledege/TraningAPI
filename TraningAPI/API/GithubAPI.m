//
//  GithubAPI.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/18.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GithubAPI.h"
#import <AFNetworking.h>



@implementation GithubAPI : NSObject
- (AnyPromise *)prefecturesAPI {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        NSString *url = @"https://covid19-japan-web-api.vercel.app/api/v1/prefectures";
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            // json取得に成功した場合の処理
                resolve(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
            // エラーの場合の処理
                resolve(error);
            }
        ];
    }];
}
@end
