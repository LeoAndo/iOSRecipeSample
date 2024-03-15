//
//  ViewController.h
//  ch5trim
//
//  Created by SHOEISHA on 2013/10/14.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end
