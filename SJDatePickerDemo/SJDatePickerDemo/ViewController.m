//
//  ViewController.m
//  SJDatePickerDemo
//
//  Created by Jaesun on 16/8/29.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "ViewController.h"

#import "SJDatePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)datePickerBtn:(id)sender {
    
   
 [SJDatePicker datePickerWithPickedDate:^(NSDate *pikcedDate) {
     
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [sender setTitle:[formatter stringFromDate:pikcedDate] forState:(UIControlStateNormal)];
    }];
    
}

@end
