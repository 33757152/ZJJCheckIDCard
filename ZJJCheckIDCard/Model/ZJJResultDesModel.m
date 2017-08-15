//
//  ZJJResultDesModel.m
//  ZJJCheckIDCard
//
//  Created by 张锦江 on 2017/8/14.
//  Copyright © 2017年 ZJJ. All rights reserved.
//

#import "ZJJResultDesModel.h"

@implementation ZJJResultDesModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self zjjInitDic];
    }
    return self;
}

- (void)zjjInitDic {
    self.desDic = @{@"1":@"验证成功!",
                    @"2":@"sorry!您输入的内容全是英文,请重新输入!",
                    @"3":@"sorry!您输入的内容包含英文,请重新输入!",
                    @"4":@"sorry!您输入的内容包含中文或特殊符号,请重新输入!",
                    @"5":@"sorry!您输入的内容长度不满足,请重新输入!",
                    @"6":@"sorry!验证失败!,请重新输入!",
                    @"7":@"sorry!您输入的生日不正确!,请重新输入!"
                    };
}



@end
