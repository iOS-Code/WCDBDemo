//
//  SomeModel+WCDBCoding.h
//  YCWCDBDemo
//
//  Created by 岳琛 on 2018/6/8.
//  Copyright © 2018年 KMF-Engineering. All rights reserved.
//

#import "SomeModel.h"
#import <WCDB/WCDB.h>

@interface SomeModel (WCDBCoding) <WCTTableCoding>

WCDB_PROPERTY(modelID)
WCDB_PROPERTY(userID)
WCDB_PROPERTY(age)
WCDB_PROPERTY(name)
WCDB_PROPERTY(sex)
WCDB_PROPERTY(phoneNumber)

@end
