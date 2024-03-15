//
//  PickerView2Controller.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/13.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "PickerView2Controller.h"

@interface PickerView2Controller ()

@end

@implementation PickerView2Controller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.uiPicker.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//UIPickerViewに表示する列数を指定するメソッド
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//UIPickerViewに表示する行数を指定するメソッド
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 3;
}

//PickerViewの各行に表示する文字列を指定するメソッド
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = @"Error";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range1 = [str rangeOfString:@"Error"];
    //赤色にセットする
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[[UIColor redColor] colorWithAlphaComponent:1.]
                    range:range1];

    NSString *str2 = @"Warn";
    NSMutableAttributedString *attrStr2 = [[NSMutableAttributedString alloc] initWithString:str2];
    NSRange range2 = [str2 rangeOfString:@"Warn"];
    //黄色にセットする
    [attrStr2 addAttribute:NSForegroundColorAttributeName
                    value:[[UIColor yellowColor] colorWithAlphaComponent:1.]
                    range:range2];
    
    NSString *str3 = @"Info";
    NSMutableAttributedString *attrStr3 = [[NSMutableAttributedString alloc] initWithString:str3];
    NSRange range3 = [str3 rangeOfString:@"Info"];
    //赤色にセットする
    [attrStr3 addAttribute:NSForegroundColorAttributeName
                    value:[[UIColor grayColor] colorWithAlphaComponent:1.]
                    range:range3];
    NSMutableAttributedString *result;
    switch (row) {
        case 0:
            result = attrStr;
            break;
        case 1:
            result = attrStr2;
            break;
        case 2:
            result = attrStr3;
            break;
        default:
            result =[[NSMutableAttributedString alloc] initWithString:@"NULL"];
            break;
    }
    
    return result;
}


- (IBAction)closePickerView:(id)sender {
    [self.delegate closePickerView:self];
}

@end
