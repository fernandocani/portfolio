//
//  PickerViewViewController.m
//  Quizz
//
//  Created by Fernando Cani on 3/23/15.
//  Copyright (c) 2015 Fernando Cani. All rights reserved.
//

#import "PickerViewViewController.h"
#import "QuizzGameViewController.h"


@interface PickerViewViewController () {
    NSArray *_pickerData;
    NSString *_pickerViewSelected;
}

@end

@implementation PickerViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickerData = @[@"Conhecimentos Gerais", @"Arquivo X", @"Coritiba F.C."];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [[self view] setBackgroundColor:[UIColor blueColor]];
    [[self view] setTintColor:      [UIColor whiteColor]];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row == 0) {
        [[self view] setBackgroundColor:[UIColor blueColor]];
        _pickerViewSelected = @"";[_pickerData objectAtIndex:row];
        NSLog(@"%@", _pickerViewSelected);
    } else if (row == 1) {
        [[self view] setBackgroundColor:[UIColor orangeColor]];
        _pickerViewSelected = [_pickerData objectAtIndex:row];
        NSLog(@"%@", _pickerViewSelected);
    } else if (row == 2) {
        [[self view] setBackgroundColor:[UIColor greenColor]];
        _pickerViewSelected = [_pickerData objectAtIndex:row];
        NSLog(@"%@", _pickerViewSelected);
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"startQuizz"]) {
        NSLog(@"prepareForSegue");
        QuizzGameViewController *controller = [segue destinationViewController];
        
        controller.perguntaEscolhidaPickerView = _pickerViewSelected;
    }
}

@end