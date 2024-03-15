//
//  Content2ViewController.h
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/13.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CloseUIPopoverControllerdelegate;

@interface Content2ViewController : UIViewController
@property (weak, nonatomic) id<CloseUIPopoverControllerdelegate> delegate;
@end

@protocol CloseUIPopoverControllerdelegate <NSObject>
- (void)closePopover:(Content2ViewController *)sender;
@end
