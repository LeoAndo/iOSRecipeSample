//
//  PickerViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/13.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()
{
    NSArray *data1;
    NSArray *data2;
}
@end

@implementation PickerViewController

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
    data1 = [NSArray arrayWithObjects:@"data1",@"data2",@"data3",@"data4",@"data5", nil];
    data2 = [NSArray arrayWithObjects:@"test1",@"test2",@"test3",@"test4",@"test5",@"test6", nil];
    self.uiPicker.delegate = self;
    self.uiPicker.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//UIPickerViewに表示する列数を指定するメソッド
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

//UIPickerViewに表示する行数を指定するメソッド
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(0 == component) {
        return data1.count;
    } else {
        return data2.count;
    }
}

//PickerViewの各行に表示する文字列を指定するメソッド
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if( 0== component){
        return [data1 objectAtIndex:row];
    } else {
        return [data2 objectAtIndex:row];
    }
    
}

/**
 * ピッカーの選択行が決まったとき
 */
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 1列目の選択された行数を取得
    NSInteger val0 = [pickerView selectedRowInComponent:0];
    
    // 2列目の選択された行数を取得
    NSInteger val1 = [pickerView selectedRowInComponent:1];
    
    NSLog(@"1列目:%@が選択", [data1 objectAtIndex:val0]);
    NSLog(@"2列目:%@が選択", [data2 objectAtIndex:val1]);
}

- (IBAction)closePickerView:(id)sender {
    // 1列目の選択された行数を取得
    NSInteger val0 = [self.uiPicker selectedRowInComponent:0];
    // 2列目の選択された行数を取得
    NSInteger val1 = [self.uiPicker selectedRowInComponent:1];
    
    NSLog(@"1列目:%@が選択", [data1 objectAtIndex:val0]);
    NSLog(@"2列目:%@が選択", [data2 objectAtIndex:val1]);
    [self.delegate closePickerView:self];
}



@end
