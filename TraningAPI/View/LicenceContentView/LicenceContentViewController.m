//
//  LicenceContentViewController.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import "LicenceContentViewController.h"

@interface LicenceContentViewController ()

@end

@implementation LicenceContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // ライセンス名設定
    self.navigationItem.title = self.titles;
    /* ライセンス表記設定 */
    self.contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.contentView setSelectable:false];
    self.contentView.text = self.content;
    [self.view addSubview:self.contentView];
}

@end
