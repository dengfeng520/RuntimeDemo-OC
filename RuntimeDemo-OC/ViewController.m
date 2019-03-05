//
//  ViewController.m
//  RuntimeDemo-OC
//
//  Created by rp.wang on 2019/3/4.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+Category.h"


static NSString * const ViewControllerCellID = @"ViewControllerCellID";

@interface ViewController ()

@property (strong, nonatomic) NSSet *listAry;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"About Runtime";
    
    _listAry = [NSSet setWithObjects:@{@"Class":@"FunctionClass",@"title":@"类方法和实例方法"},
                @{@"Class":@"msgSendClassController",@"title":@"objc_msgSend方法"},
                @{@"Class":@"",@"title":@"消息发送流程"},
                @{@"Class":@"",@"title":@"类方法动态消息解析"},
                @{@"Class":@"",@"title":@"实例方法动态消息解析"},
                @{@"Class":@"",@"title":@"重定向"},
                @{@"Class":@"",@"title":@"转发"},
                @{@"Class":@"",@"title":@"模拟多继承"},
                @{@"Class":@"",@"title":@"获取一个类objc_getClass"}, nil];
    
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = footerView;
}

-(NSSet *)listAry{
    if(_listAry == nil){
        _listAry = [[NSSet alloc]init];
    }
    return _listAry;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ViewControllerCellID forIndexPath:indexPath];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[[[_listAry allObjects] objectAtIndex:indexPath.row]objectForKey:@"title"]];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //====================================
    NSString *Class = [NSString stringWithFormat:@"%@",[[[_listAry allObjects] objectAtIndex:indexPath.row]objectForKey:@"Class"]];
    UIViewController *view = [[NSClassFromString(Class) alloc]init];
    view.title = [NSString stringWithFormat:@"%@",[[[_listAry allObjects] objectAtIndex:indexPath.row]objectForKey:@"title"]];
    [self.navigationController pushViewController:view animated:YES];
}


@end
