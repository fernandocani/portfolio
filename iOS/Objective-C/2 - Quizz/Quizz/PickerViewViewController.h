//
//  PickerViewViewController.h
//  Quizz
//
//  Created by Fernando Cani on 3/23/15.
//  Copyright (c) 2015 Fernando Cani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIButton *btnStart;

@end