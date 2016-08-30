//
//  SJDatePicker.h
//  ProjectOC
//
//  Created by Jaesun on 16/8/16.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 SJDatePicker *datePicker = [SJDatePicker datePickerWithPickedDate:^(NSDate *pickedDate) {
 NSLog(@"pcikedDate is -- %@",[pickedDate dateStringWithFormat:@"yyyy-MM-dd"]);
 
 }];
 
 datePicker.minimumDate = [NSDate date];
 datePicker.maximumDate = ;
 datePicker.datePickerMode = UIDatePickerModeDateAndTime;
 datePicker.dateFormate = @"yyyy-MM-dd HH:mm";
 
 }];

*/

/**
 *  屏幕宽度
 */
#define SCREEN_WIDTH CGRectGetWidth([[UIScreen mainScreen] bounds])
/**
 *  屏幕高度
 */
#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])

typedef void(^DatePickerBlock)(NSDate *pikcedDate);

@interface SJDatePicker : UIViewController

/**
 *  时间选择器的最大时间
 */
@property (nonatomic, strong) NSDate *maximumDate;

/**
 *  时间选择器的最小时间
 */
@property (nonatomic, strong) NSDate *minimumDate;
/**
 *  时间格式
 */
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
/**
 *  时间格式化
 */
@property (nonatomic, strong) NSString *dateFormate;

+ (instancetype) datePickerWithPickedDate:(DatePickerBlock)datePicker;

@end
