//
//  AbuStcokModel.h
//  阿布搜索Demo
//
//  Created by 阿布 on 17/3/15.
//  Copyright © 2017年 阿布. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbuStcokModel : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *cnName;
@property (nonatomic, copy) NSString *enName;
@property (nonatomic, copy) NSString *cnSpell;
@property (nonatomic, copy) NSString *cnSpellAbbr;
@property (nonatomic, copy) NSString *ftName;
/**
 * dataType 10000: 港股股票，10001: 港股指数，10002: 港股ETF；
 20000: 美股股票，20001: 美股指数, 20002: 美股ETF
 */
@property (nonatomic, copy) NSString *dataType;
@end
