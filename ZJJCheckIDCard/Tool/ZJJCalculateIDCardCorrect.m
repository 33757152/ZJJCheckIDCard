//
//  ZJJCalculateIDCardCorrect.m
//  ZJJCheckIDCard
//
//  Created by 张锦江 on 2017/8/14.
//  Copyright © 2017年 ZJJ. All rights reserved.
//

#import "ZJJCalculateIDCardCorrect.h"

NSString *_IDCardStr = nil;

@implementation ZJJCalculateIDCardCorrect

+ (int)checkIDCardIsCorrectWithStr:(NSString *)IDCardString {
    _IDCardStr = IDCardString;
    if (_IDCardStr.length != 18) {
        return 5;
    }
    int isHaveLetter = [self checkIsHaveNumAndLetter:[self obtainSpecifiedPartWithLocation:0 andLength:17]];
    if (isHaveLetter != 1) {
        return isHaveLetter;
    }
    int isBirthdayValid = [self judgeBirghdayValid];
    if (isBirthdayValid != 1) {
        return isBirthdayValid;
    }
    return [self judgeIDCardNOValid];
}

+ (NSString *)obtainSpecifiedPartWithLocation:(NSInteger)location andLength:(NSInteger)length {
    NSRange range = NSMakeRange(location, length);
    return [_IDCardStr substringWithRange:range];
}
+ (int)checkIsHaveNumAndLetter:(NSString*)password{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, password.length)];
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    if (tNumMatchCount == password.length) {
        //全部符合数字，表示沒有英文
        return 1;
    } else if (tLetterMatchCount == password.length) {
        //全部符合英文，表示沒有数字
        return 2;
    } else if (tNumMatchCount + tLetterMatchCount == password.length) {
        //符合英文和符合数字条件的相加等于密码长度
        return 3;
    } else {
        return 4;
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }
}

+ (int)judgeBirghdayValid {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    if([formatter dateFromString:[self obtainSpecifiedPartWithLocation:6 andLength:8]] == nil){
        return 7;
    }
    return 1;
}
+ (int)judgeIDCardNOValid {
    NSArray *fixedArray = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
    NSInteger sum = 0;
    for (NSInteger i = 0; i<fixedArray.count; i++) {
        NSInteger everyNO = [[self obtainSpecifiedPartWithLocation:i andLength:1] integerValue];
        NSInteger fixedNO = [fixedArray[i] integerValue];
        sum += everyNO * fixedNO;
    }
    return [self inspectLastNOIsRightWithRemaind:sum % 11];
}

+ (int)inspectLastNOIsRightWithRemaind:(NSInteger)remaind {
    NSArray *lastNOArray =@[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    if ([[self obtainSpecifiedPartWithLocation:17 andLength:1] isEqualToString:lastNOArray[remaind]]) {
        return 1;
    }
    return 6;
}

@end
