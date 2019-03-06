//
//  SendMessageViewController.m
//  RuntimeDemo-OC
//
//  Created by rp.wang on 2019/3/5.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import "SendMessageViewController.h"
#import <WebKit/WebKit.h>

@interface SendMessageViewController ()

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation SendMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/dengfeng520/RuntimeDemo-OC/blob/master/%E6%B6%88%E6%81%AF%E5%8F%91%E9%80%81%E6%B5%81%E7%A8%8B.jpg?raw=true"]]];

    

}



@end
