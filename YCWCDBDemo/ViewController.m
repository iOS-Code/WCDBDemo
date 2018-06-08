//
//  ViewController.m
//  YCWCDBDemo
//
//  Created by 岳琛 on 2018/6/8.
//  Copyright © 2018年 KMF-Engineering. All rights reserved.
//

#import "ViewController.h"
#import "SomeModel.h"
#import "WCDBManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *creatBtn;
@property (nonatomic,assign) NSInteger num;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_creatBtn addTarget:self action:@selector(creatButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn  addTarget:self action:@selector(insertButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_deleteBtn addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_selectBtn addTarget:self action:@selector(seleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_updateBtn addTarget:self action:@selector(updateButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.num = 0;
}

// 创建数据库
- (void)creatButtonClick
{
    BOOL  result = [[WCDBManager shareInstance] creatDatabase];
    NSLog(@"%@",((result == YES)?@"创建数据库成功":@"创建数据库失败"));
}

// 插入数据
- (void)insertButtonClick
{
    int x = arc4random() % 100;
    self.num++;
    
    SomeModel *pp = [[SomeModel alloc]init];
    pp.modelID = self.num;
    pp.userID = 1600+self.num;
    pp.name = [NSString stringWithFormat:@"Hello WCDB%lu",self.num];
    pp.age = x;
    
    BOOL  result = [[WCDBManager shareInstance] insertData:pp];
    NSLog(@"%@",((result == YES)?@"数据插入成功":@"数据插入失败"));
}

// 删除
- (void)deleteButtonClick
{
    BOOL  result = [[WCDBManager shareInstance] deleteDataWithId:1602];
    NSLog(@"%@",((result == YES)?@"删除9202数据成功":@"删除数据失败"));
}

// 查找数据
- (void)seleteButtonClick
{
    NSArray * array = [[WCDBManager shareInstance] seleteModelOrderBy];
    NSLog(@"%@",array);
}

// 更新数据
- (void)updateButtonClick
{
    BOOL  result = [[WCDBManager shareInstance] updateData:@"改名了" byId:1603];
    NSLog(@"%@",((result == YES)?@"修改9203数据成功":@"修改数据失败"));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
