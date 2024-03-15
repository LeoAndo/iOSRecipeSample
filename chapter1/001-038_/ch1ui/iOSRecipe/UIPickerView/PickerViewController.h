//
//  PickerViewController.h
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/13.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClosePickerViewDeledate.h"

@interface PickerViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *uiPicker;
@property (nonatomic, assign) id<ClosePickerViewDeledate> delegate;
@end

