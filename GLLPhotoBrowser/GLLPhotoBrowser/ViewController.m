//
//  ViewController.m
//  GLLPhotoBrowser
//
//  Created by 淘卡淘 on 2017/1/16.
//  Copyright © 2017年 taokatao. All rights reserved.
//

#define  cellID @"merchatnAdModelCellID"

#import "ViewController.h"

#import "MechantAdModel.h"

#import "merchatnAdModelCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *tableArray;;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
//    [_myTableView registerClass:[merchatnAdModelCell class] forCellReuseIdentifier:cellID];
    
    _tableArray = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *imageUrlStrArray = [NSArray arrayWithObjects:@"http://ww3.sinaimg.cn/large/006ka0Iygw1f6bqm7zukpj30g60kzdi2.jpg",@"http://ww1.sinaimg.cn/large/61b69811gw1f6bqb1bfd2j20b4095dfy.jpg",@"http://ww1.sinaimg.cn/large/54477ddfgw1f6bqkbanqoj20ku0rsn4d.jpg",@"http://ww4.sinaimg.cn/large/006ka0Iygw1f6b8gpwr2tj30bc0bqmyz.jpg",@"http://ww2.sinaimg.cn/large/9c2b5f31jw1f6bqtinmpyj20dw0ae76e.jpg",@"http://ww1.sinaimg.cn/large/86afb21egw1f6bq3lq0itj20gg0c2myt.jpg", nil];
    NSArray *imageHightUrlStrArray = [NSArray arrayWithObjects:@"http://ww2.sinaimg.cn/bmiddle/904c2a35jw1emu3ec7kf8j20c10epjsn.jpg",@"http://ww2.sinaimg.cn/bmiddle/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",@"http://ww2.sinaimg.cn/bmiddle/67307b53jw1epqq3bmwr6j20c80axmy5.jpg",@"http://ww2.sinaimg.cn/bmiddle/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",@"http://ww1.sinaimg.cn/bmiddle/9be2329dgw1etlyb1yu49j20c82p6qc1.jpg",@"http://ww2.sinaimg.cn/bmiddle/642beb18gw1ep3629gfm0g206o050b2a.gif", nil];
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict1 setObject:@"张三" forKey:@"nickNameStr"];
    [dict1 setObject:@"http://ww4.sinaimg.cn/bmiddle/406ef017jw1ec40av2nscj20ip4p0b29.jpg" forKey:@"headerUrlStr"];
    [dict1 setObject:@"挥别2016，迎来2017过去这一年你是否经历了涨薪，降薪，换老板，换城市，换行业，换女票，搞不好啥都换了。世事无常，唯一不变的是咱们CocoaChina一年一度的收入大调查。（历年报告：2015   2014   2013）现诚邀广大iOS开发者参与本次收入调研~~为呈现2016年真实的 iOS行业现状贡献点小力量~我们将在3月份前，在CocoaChina发布调研结果。下面开始伤害吧~~" forKey:@"contentStr"];
    [dict1 setObject:imageUrlStrArray forKey:@"imageUrlArray"];
    [dict1 setObject:imageHightUrlStrArray forKey:@"imageHightUrlStrArray"];
    
    MechantAdModel *adModel = [[MechantAdModel alloc] initWithDict:dict1];
    [_tableArray addObject:adModel];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict2 setObject:@"李四" forKey:@"nickNameStr"];
    [dict2 setObject:@"http://ww4.sinaimg.cn/bmiddle/406ef017jw1ec40av2nscj20ip4p0b29.jpg" forKey:@"headerUrlStr"];
    [dict2 setObject:@"挥别2016，迎来2017过去这一年你是否经历了涨薪，降薪" forKey:@"contentStr"];
    [dict2 setObject:imageUrlStrArray forKey:@"imageUrlArray"];
    [dict2 setObject:imageHightUrlStrArray forKey:@"imageHightUrlStrArray"];
    
    MechantAdModel *adModel1 = [[MechantAdModel alloc] initWithDict:dict2];
    [_tableArray addObject:adModel1];
    
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict3 setObject:@"王五" forKey:@"nickNameStr"];
    [dict3 setObject:@"http://ww4.sinaimg.cn/bmiddle/406ef017jw1ec40av2nscj20ip4p0b29.jpg" forKey:@"headerUrlStr"];
    [dict3 setObject:@"挥别2016，迎来2017过去这一年你是否经历了涨薪，降薪，换老板，换城市，换行业，换女票" forKey:@"contentStr"];
    [dict3 setObject:imageUrlStrArray forKey:@"imageUrlArray"];
    [dict3 setObject:imageHightUrlStrArray forKey:@"imageHightUrlStrArray"];
    
    MechantAdModel *adModel2 = [[MechantAdModel alloc] initWithDict:dict3];
    [_tableArray addObject:adModel2];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    merchatnAdModelCell *cell = (merchatnAdModelCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    merchatnAdModelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[merchatnAdModelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    MechantAdModel *adModel = [_tableArray objectAtIndex:indexPath.row];
    
    cell.adModel = adModel;
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
