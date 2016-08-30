//
//  SJDatePicker.m
//  ProjectOC
//
//  Created by Jaesun on 16/8/16.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJDatePicker.h"

@interface SJDatePicker ()

/**
 *  时间选择器的显示window
 */
@property (nonatomic, strong) UIWindow *datePickerWindow;
/**
 *  时间选择器
 */
@property (nonatomic, strong) UIDatePicker *datePicker;
/**
 *  显示 取消 确定按钮 的工具栏
 */
@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) UILabel *dateLab;

/**
 *  时间选择回调
 */
@property (nonatomic, strong) DatePickerBlock datePickerBlock;


@end

@implementation SJDatePicker

#pragma mark- 外部显示接口
#pragma mark-
+ (instancetype) datePickerWithPickedDate:(DatePickerBlock)datePicker {
    
    return [[self alloc] initDatePickerSelectedDate:datePicker];
}

#pragma mark- 初始化方法
#pragma mark-
- (instancetype) initDatePickerSelectedDate:(DatePickerBlock)datePicker {
    
    self = [super init];
    
    if (self) {
        
        // datePickerWindow 时间选择器的显示window
        {
            self.datePickerWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            self.datePickerWindow.windowLevel = UIWindowLevelAlert;
            self.datePickerWindow.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
            self.datePickerWindow.rootViewController = self;
        }
        
        // 时间选择器
        {
            self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 216, self.view.frame.size.width, 216)];
            self.datePicker.backgroundColor = [UIColor whiteColor];
            self.datePicker.datePickerMode = UIDatePickerModeDate;
            [self.datePicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
            self.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
             [self.view addSubview:self.datePicker];
        }
        
        // 显示 取消 确定按钮 时间标签 的工具栏
        {
            self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 260, self.view.frame.size.width, 44.0f)];
            self.toolBar.backgroundColor = [UIColor lightGrayColor];
            
            UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
            UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            self.dateLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 30)];
                                         
            self.dateLab.font = [UIFont systemFontOfSize:15];
            self.dateLab.textColor = [UIColor grayColor];

            if (!self.dateFormate) {
               self.dateFormate = @"";
            }
           
            self.dateLab.textAlignment = NSTextAlignmentCenter;
            
            UIBarButtonItem *centerItem = [[UIBarButtonItem alloc] initWithCustomView:self.dateLab];

            UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmAction)];
            [self.toolBar setItems:@[leftItem,flexSpace,centerItem,flexSpace,rightItem]];
           
            [self.view addSubview:self.toolBar];
        }
        [self show];
        
        self.datePickerBlock = datePicker;
    }
    return  self;

}
#pragma mark- 属性的 set get 方法
#pragma mark-

- (void)setMaximumDate:(NSDate *)maximumDate {
    self.datePicker.maximumDate = maximumDate;
}
- (NSDate *)maximumDate {
    return self.datePicker.maximumDate;
}
- (void)setMinimumDate:(NSDate *)minimumDate {
    self.datePicker.minimumDate = minimumDate;
}
- (NSDate *)minimumDate {
    return  self.datePicker.minimumDate;
}
- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode {
    self.datePicker.datePickerMode = datePickerMode;
}
- (UIDatePickerMode)datePickerMode {
    return self.datePicker.datePickerMode;
}
- (void)setDateFormate:(NSString *)dateFormate {
    _dateFormate = dateFormate;
    self.dateLab.text =  [self stringWithDate:self.datePicker.date format:dateFormate];
}

#pragma mark- 点击事件
#pragma mark-

#pragma mark 取消按钮
- (void)cancelAction {
    [self dismiss];
}

#pragma mark 确认按钮
- (void)confirmAction {
    [self dismiss];
    self.datePickerBlock(self.datePicker.date);
}
#pragma mark 时间选择器
- (void)dateChange:(UIDatePicker *)sender {
    self.dateLab.text = [self stringWithDate:sender.date format:self.dateFormate];
}


#pragma mark- 其他方法
#pragma mark-

#pragma mark 视图消失
- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.datePickerWindow.alpha = 0;
        [self.view removeFromSuperview];
    }];
}

#pragma mark 视图出现
- (void)show {
    [self.datePickerWindow addSubview:self.view];
    [self.datePickerWindow makeKeyAndVisible];
}

- (NSString *) stringWithDate:(NSDate *)date format:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (format.length == 0) {
        [formatter setDateFormat: @"yyyy-MM-dd"];
    }
    NSString *string = [formatter stringFromDate:date];
    return string;
}

@end
