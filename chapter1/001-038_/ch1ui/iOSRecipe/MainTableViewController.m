//
//  MainTableViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2013/12/30.
//  Copyright (c) 2013年 shaoeisya. All rights reserved.
//

#import "MainTableViewController.h"
#import "UILabel/Ch01_UILabel_01_ViewController.h"
#import "UILabel/Ch01_UILabel_02_ViewController.h"
#import "UILabel/Ch01_UILabel_03_ViewController.h"
#import "UIProgressView/Ch01_UIProgressView_01_ViewController.h"
#import "UIProgressView/Ch01_UIProgressView_02_ViewController.h"
#import "UIButton/Ch01_UIButton_01_ViewController.h"
#import "UIButton/Ch01_UIButton_02_ViewController.h"
#import "UISlider/Ch01_UISlider_01_ViewController.h"
#import "UISlider/Ch01_UISlider_02_ViewController.h"
#import "UITextField/Ch01_UITextField_01_ViewController.h"
#import "UITextField/Ch01_UITextField_02_ViewController.h"
#import "UITextField/Ch01_UITextField_03_ViewController.h"
#import "UITextField/Ch01_UITextField_05_ViewController.h"
#import "UITextView/Ch01_UITextView_01_ViewController.h"
#import "UIAlertView/Ch01_UIAlertView_01_ViewController.h"
#import "UIAlertView/Ch01_UIAlertView_02_ViewController.h"
#import "UIPopoverController/Ch01_UIPopoverController_01_ViewController.h"
#import "UIPopoverController/Ch01_UIPopoverController_02_ViewController.h"
#import "UIActionSheet/Ch01_UIActionSheet_01_ViewController.h"
#import "UIPickerView/Ch01_UIPickerView_01_ViewController.h"
#import "UIPickerView/Ch01_UIPickerView_02_ViewController.h"
#import "UIDatePicker/Ch01_UIDatePicker_01_ViewController.h"
#import "UIDatePicker/Ch01_UIDatePicker_02_ViewController.h"
#import "UIDatePicker/Ch01_UIDatePicker_03_ViewController.h"
#import "UIImageView/Ch01_UIImageView_01_ViewController.h"
#import "UIImageView/Ch01_UIImageView_02_ViewController.h"
#import "UIImageView/Ch01_UIImageView_04_ViewController.h"
#import "UISwitch/Ch01_UISwitch_01_ViewController.h"
#import "UISegmentedControl/Ch01_UISegmentedControl_01_ViewController.h"
#import "UISegmentedControl/Ch01_UISegmentedControl_02_ViewController.h"
#import "UISegmentedControl/Ch01_UISegmentedControl_03_ViewController.h"
#import "UISegmentedControl/Ch01_UISegmentedControl_04_ViewController.h"

@interface MainTableViewController (){
    NSArray *labelArray;
    NSArray *progressviewArray;
    NSArray *buttonArray;
    NSArray *sliderArray;
    NSArray *switchArray;
    NSArray *segmentedControlArray;
    NSArray *textfieldArray;
    NSArray *textAreaArray;
    NSArray *alertViewArray;
    NSArray *popoverArray;
    NSArray *actionSheetArray;
    NSArray *tableArray;
    NSArray *pickerArray;
    NSArray *datePickerArray;
    NSArray *imageviewArray;
    NSArray *allArray;
}
@end

@implementation MainTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    labelArray=[NSArray arrayWithObjects:[Ch01_UILabel_01_ViewController class],[Ch01_UILabel_02_ViewController class],[Ch01_UILabel_03_ViewController class], nil];
    progressviewArray=[NSArray arrayWithObjects:[Ch01_UIProgressView_01_ViewController class],[Ch01_UIProgressView_02_ViewController class], nil];
    buttonArray=[NSArray arrayWithObjects:[Ch01_UIButton_01_ViewController class],[Ch01_UIButton_02_ViewController class],nil];
    sliderArray=[NSArray arrayWithObjects:[Ch01_UISlider_01_ViewController class],[Ch01_UISlider_02_ViewController class],nil];
    
    switchArray=[NSArray arrayWithObjects:[Ch01_UISwitch_01_ViewController class],nil];
    
    segmentedControlArray = [NSArray arrayWithObjects:[Ch01_UISegmentedControl_01_ViewController class],[Ch01_UISegmentedControl_02_ViewController class],
        [Ch01_UISegmentedControl_03_ViewController class],
        [Ch01_UISegmentedControl_04_ViewController class],nil];
    
    textfieldArray=[NSArray arrayWithObjects:[Ch01_UITextField_01_ViewController class],[Ch01_UITextField_02_ViewController class],[Ch01_UITextField_03_ViewController class],
                   [Ch01_UITextField_05_ViewController class],nil];
    
    textAreaArray = [NSArray arrayWithObjects:[Ch01_UITextView_01_ViewController class],nil];
    
    alertViewArray = [NSArray arrayWithObjects:[Ch01_UIAlertView_01_ViewController class],[Ch01_UIAlertView_02_ViewController class],nil];
    
    popoverArray = [NSArray arrayWithObjects:[Ch01_UIPopoverController_01_ViewController class],[Ch01_UIPopoverController_02_ViewController class],nil];
    
    actionSheetArray = [NSArray arrayWithObjects:[Ch01_UIActionSheet_01_ViewController class],nil];
    
    tableArray = [NSArray arrayWithObjects:@"Ch01_UITableView_01_Storyboard",@"Ch01_UITableView_02_Storyboard",@"Ch01_UITableView_03_Storyboard",@"Ch01_UITableView_04_Storyboard", nil];
    
    pickerArray = [NSArray arrayWithObjects:[Ch01_UIPickerView_01_ViewController class],[Ch01_UIPickerView_02_ViewController class],nil];
    
    datePickerArray = [NSArray arrayWithObjects:[Ch01_UIDatePicker_01_ViewController class],[Ch01_UIDatePicker_02_ViewController class],[Ch01_UIDatePicker_03_ViewController class],nil];
    
    imageviewArray = [NSArray arrayWithObjects:[Ch01_UIImageView_01_ViewController class],[Ch01_UIImageView_02_ViewController class],[Ch01_UIImageView_04_ViewController class],nil];
    
    allArray =[NSArray arrayWithObjects:labelArray,progressviewArray,buttonArray,switchArray,segmentedControlArray,sliderArray,textfieldArray,textAreaArray, alertViewArray,popoverArray,actionSheetArray,tableArray,pickerArray,datePickerArray,imageviewArray,nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger sectonIndex = indexPath.section;
    
    NSInteger rowIndex = indexPath.row;
    
    
    if(sectonIndex == 11) {
        NSString *myname = [[allArray objectAtIndex:sectonIndex] objectAtIndex:rowIndex];
        UIStoryboard *tableviewStoryboard = [UIStoryboard storyboardWithName:myname bundle:nil] ;
        id next = [tableviewStoryboard instantiateInitialViewController];
        [self.navigationController pushViewController:next animated:YES];
        return;
    }
    
    UIViewController *next;
    
    next = [[[[allArray objectAtIndex:sectonIndex] objectAtIndex:rowIndex] alloc]init];
 
    // Push the view controller.
    [self.navigationController pushViewController:next animated:YES];
}

@end
