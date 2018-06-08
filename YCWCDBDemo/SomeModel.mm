//
//  SomeModel.m
//  YCWCDBDemo
//
//  Created by 岳琛 on 2018/6/8.
//  Copyright © 2018年 KMF-Engineering. All rights reserved.
//

#import "SomeModel.h"
#import "SomeModel+WCDBCoding.h"

@implementation SomeModel

WCDB_IMPLEMENTATION(SomeModel)

WCDB_SYNTHESIZE(SomeModel, modelID)
WCDB_SYNTHESIZE(SomeModel, userID)
WCDB_SYNTHESIZE(SomeModel, age)
WCDB_SYNTHESIZE(SomeModel, name)
WCDB_SYNTHESIZE(SomeModel, sex)
WCDB_SYNTHESIZE(SomeModel, phoneNumber)

WCDB_PRIMARY_AUTO_INCREMENT(SomeModel, modelID)

@end
