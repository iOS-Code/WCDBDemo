//
//  WCDBManager.h
//  YCWCDBDemo
//
//  Created by 岳琛 on 2018/6/8.
//  Copyright © 2018年 KMF-Engineering. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SomeModel;

@interface WCDBManager : NSObject

+ (instancetype)shareInstance;

+ (NSString *)wcdbFilePath;

- (BOOL)creatDatabase;

#pragma mark - 增
- (BOOL)insertData:(SomeModel *)model;

- (BOOL)insertDatas:(NSArray<SomeModel *> *)model;

- (BOOL)insertModel;

// WCTDatabase 事务操作，利用WCTTransaction
- (BOOL)insertModelWithTransaction;

// 另一种事务处理方法Block
- (BOOL)insertPersonWithBlock;

#pragma mark - 删
- (BOOL)deleteDataWithId:(NSInteger)userid;
- (BOOL)deleteAllData;

#pragma mark - 改
- (BOOL)updateData:(NSString *)content byId:(NSInteger)userID;

- (BOOL)updateData:(SomeModel *)model;
#pragma mark - 查
- (NSArray<SomeModel *> *)getAllData;
- (NSArray<SomeModel *> *)getData:(NSInteger)userid;
- (NSArray<SomeModel *> *)seleteModelOrderBy;
@end
