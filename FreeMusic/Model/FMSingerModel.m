//
//  FMSingerModel.m
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-27.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import "FMSingerModel.h"

@implementation FMSingerModel
//表名
+(NSString *)getTableName
{
    return @"FMSongerInfor";
}

//表版本
+(int)getTableVersion
{
    return 1;
}

+(NSString *)getPrimaryKey
{
    return @"ting_uid";
}

-(NSMutableArray *)itemWith:(NSString *)name
{
    NSLog(@"%s", __func__);
    NSMutableArray * array = [FMSingerModel searchWithWhere:[NSString stringWithFormat:@"name like '%%%@%%'",name]
                                                    orderBy:nil
                                                     offset:0
                                                      count:0];
    NSMutableArray * temp = [NSMutableArray new];
    NSMutableArray * temp1 = [NSMutableArray new];
    for (FMSingerModel * model in array) {
        if ([model.name length] != 0) {
            if ([model.company length] != 0) {
                [temp addObject:model];
            }
            else {
                [temp1 addObject:model];
            }
        }
    }
    [temp addObjectsFromArray:temp1];
    return temp;
}

-(NSMutableArray *)itemTop100
{
//    NSMutableArray * array = [FMSingerModel searchWithWhere:[NSString stringWithFormat:@"'songs_total' >1000"] orderBy:nil offset:0 count:50];
    return [self itemWith:@"张"];
}

@end
