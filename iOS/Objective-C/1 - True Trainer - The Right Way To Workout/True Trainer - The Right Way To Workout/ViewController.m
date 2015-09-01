//
//  ViewController.m
//  True Trainer - The Right Way To Workout
//
//  Created by Fernando Cani on 3/4/15.
//  Copyright (c) 2015 True Trainer. All rights reserved.
//

#import "ViewController.h"

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


- (IBAction)backConfiguration:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end