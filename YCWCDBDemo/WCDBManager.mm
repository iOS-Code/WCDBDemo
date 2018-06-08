//
//  WCDBManager.m
//  YCWCDBDemo
//
//  Created by 岳琛 on 2018/6/8.
//  Copyright © 2018年 KMF-Engineering. All rights reserved.
//

#import "WCDBManager.h"
#import "SomeModel+WCDBCoding.h"

#define TABLE_WCDB_NAME @"SomeModdelDDD"

@interface WCDBManager ()
{
    WCTDatabase * database;
}
@end

@implementation WCDBManager

+ (instancetype)shareInstance
{
    static WCDBManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WCDBManager alloc]init];
    });
    return instance;
}

+ (NSString *)wcdbFilePath
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath = [docDir stringByAppendingPathComponent:@"SomeModel.db"];
    NSLog(@"%@",dbFilePath);
    return dbFilePath;
}

- (BOOL)creatDatabase
{
    database = [[WCTDatabase alloc] initWithPath:[WCDBManager wcdbFilePath]];
    
    //测试数据库是否能够打开
    if ([database canOpen]) {
        // WCDB大量使用延迟初始化（Lazy initialization）的方式管理对象，因此SQLite连接会在第一次被访问时被打开。开发者不需要手动打开数据库。
        // 先判断表是不是已经存在
        if ([database isOpened]) {
            if ([database isTableExists:TABLE_WCDB_NAME]) {
                NSLog(@"表已经存在");
                return NO;
            } else {
                return [database createTableAndIndexesOfName:TABLE_WCDB_NAME withClass:SomeModel.class];
            }
        }
    }
    return NO;
}

#pragma mark - 增
- (BOOL)insertData:(SomeModel *)model
{
    if (model == nil) {
        return NO;
    }
    if (database == nil) {
        [self creatDatabase];
    }
    return [database insertObject:model into:TABLE_WCDB_NAME];
}

- (BOOL)insertDatas:(NSArray<SomeModel *> *)model
{
    if (database == nil) {
        [self creatDatabase];
    }
    return [database insertObjects:model into:TABLE_WCDB_NAME];
}

- (BOOL)insertModel
{
    //插入
    SomeModel * obj = [[SomeModel alloc] init];
    obj.name = @"Hello, WCDB!";
    obj.age = 12;
    return  [database insertObject:obj into:TABLE_WCDB_NAME];
}

// WCTDatabase 事务操作，利用WCTTransaction
- (BOOL)insertModelWithTransaction
{
    BOOL ret = [database beginTransaction];
    ret = [self insertModel];
    if (ret)
        [database commitTransaction];
    else
        [database rollbackTransaction];
    
    return ret;
}

// 另一种事务处理方法Block
- (BOOL)insertPersonWithBlock
{
    BOOL commited  =  [database runTransaction:^BOOL {
        BOOL result = [self insertModel];
        if (result)
            return YES;
        else
            return NO;
    } event:^(WCTTransactionEvent event) {
        NSLog(@"Event %d", event);
    }];
    return commited;
}

#pragma mark - 删
- (BOOL)deleteDataWithId:(NSInteger)userid
{
    if (database == nil) {
        [self creatDatabase];
    }
    return [database deleteObjectsFromTable:TABLE_WCDB_NAME where:SomeModel.userID == userid];
}

- (BOOL)deleteAllData
{
    if (database == nil) {
        [self creatDatabase];
    }
    return [database deleteAllObjectsFromTable:TABLE_WCDB_NAME];
}

#pragma mark - 改
- (BOOL)updateData:(NSString *)content byId:(NSInteger)userID
{
    if (database == nil) {
        [self creatDatabase];
    }
    SomeModel * obj = [[SomeModel alloc] init];
    obj.name = content;
    return [database updateRowsInTable:TABLE_WCDB_NAME onProperties:SomeModel.name withObject:obj where:SomeModel.userID == userID];
}

- (BOOL)updateData:(SomeModel *)model
{
    if (database == nil) {
        [self creatDatabase];
    }
    return [database updateRowsInTable:TABLE_WCDB_NAME onProperties:SomeModel.name withObject:model where:SomeModel.userID == model.userID];
}

#pragma mark - 查
- (NSArray<SomeModel *> *)getAllData
{
    if (database == nil) {
        [self creatDatabase];
    }
    return [database getAllObjectsOfClass:SomeModel.class fromTable:TABLE_WCDB_NAME];
}

- (NSArray<SomeModel *> *)getData:(NSInteger)userid
{
    if (database == nil) {
        [self creatDatabase];
    }
    return [database getObjectsOfClass:SomeModel.class fromTable:TABLE_WCDB_NAME where:SomeModel.userID == userid];
}

- (NSArray<SomeModel *> *)seleteModelOrderBy
{
    //SELECT * FROM message ORDER BY localID
    NSArray<SomeModel *> * model = [database getObjectsOfClass:SomeModel.class fromTable:TABLE_WCDB_NAME orderBy:SomeModel.modelID.order()];
    return model;
}

@end
