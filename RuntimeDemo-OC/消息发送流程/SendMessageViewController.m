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
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.99.81:8020/goldenWater/watersupermarketList.html"]]];

    

}



@end
