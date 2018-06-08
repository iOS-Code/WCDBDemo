//
//  SomeModel.h
//  YCWCDBDemo
//
//  Created by 岳琛 on 2018/6/8.
//  Copyright © 2018年 KMF-Engineering. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 随便创建一个model  就叫做someModel吧   然后随便定义几个用户的属性 当作是用户模型吧
 
 QRM绑定：
 1、定义这个模型类，遵守WCTTableCoding协议，可以在h中实现，也可以通过分类实现
 推荐使用分类，通过文件模板在category内定义，可以隔离OC++的代码
 
 WCDB基于WINQ，引入了Objective-C++代码，所以引入WCDB的源文件，需要把后缀.m改为.mm，为减少影响范围，可以通过Objective-C的category特性将其隔离，达到只在model层使用Objective-C++编译，而不影响Controller和View。
 
 这么说吧，要是我们通过类的声明中实现，这样在.h使用了WCDB的代码，引用模型的文件中，比如其他Controller/View/VM中引用的时候，那相应文件的.m就需要修改成.mm。
 
 2、使用WCDB_PROPERTY宏在头文件声明需要绑定到数据库表的字段（也就是把你的表里面需要的字段在这里用这宏声明一次）
 3、使用WCDB_IMPLEMENTATIO宏在类文件定义绑定到数据库表的类（把这个类绑定到数据库的表，你会在下面创建数据库的时候创建相应的表，表会和类绑定）
 4、使用WCDB_SYNTHESIZE宏在类文件定义绑定到数据库表的类（第二步声明了表需要的字段，第三步绑定了表中的类，第四步就等于把表和字段绑定）
 */


@interface SomeModel : NSObject

@property (nonatomic,assign) NSInteger modelID;
@property (nonatomic,assign) NSInteger userID;
@property (nonatomic,assign) NSInteger age;

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * sex;
@property (nonatomic,copy) NSString * phoneNumber;

@end
