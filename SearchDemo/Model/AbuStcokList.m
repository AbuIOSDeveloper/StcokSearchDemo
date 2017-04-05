//
//  AbuStcokList.m
//  阿布搜索Demo
//
//  Created by 阿布 on 17/3/15.
//  Copyright © 2017年 阿布. All rights reserved.
//

#import "AbuStcokList.h"
#import "AbuStcokModel.h"
@implementation AbuStcokList

static NSMutableArray * Data;

+ (NSMutableArray *)getStcokData
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"CDefaultNetworkingFile" ofType: @"json"];
    NSData *data = [NSData dataWithContentsOfFile: path];
    
    NSError *error = nil;
    NSArray *array = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error:&error];
    NSMutableArray * dataArray = [NSMutableArray array];
    if (IsArrayNull(Data)) {
        for (NSDictionary * dict in array) {
            AbuStcokModel * model = [AbuStcokModel new];
            [model setValuesForKeysWithDictionary:dict];
            [dataArray addObject:model];
        }
    }
    Data = dataArray;
    return Data;
}

@end
