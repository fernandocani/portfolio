//
//  ProjectSettingsViewController.m
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import "ProjectSettingsViewController.h"
#import "ProjectsManager.h"
#import "Project.h"

@implementation ProjectSettingsViewController {
    __weak IBOutlet UITextField *tfProjectName;
    ProjectsManager* pm;
    __weak IBOutlet UIBarButtonItem *btnDone;
}

- (void)viewDidLoad {
    pm = [ProjectsManager sharedInstance];
    [self onProjectNameChange: self];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden: NO animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    if (tfProjectName.text.length <= 0)
        [tfProjectName becomeFirstResponder];
}

- (IBAction)done:(id)sender {
    if (!self.project) {
        self.project = [[Project alloc] initWithName:tfProjectName.text];
        [pm.projects addObject:self.project];
    }
    else {
        self.project.name = tfProjectName.text;
    }
    [pm save];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Events

- (IBAction)onProjectNameChange:(id)sender {
    btnDone.enabled = tfProjectName.text.length > 0;
}

@end
