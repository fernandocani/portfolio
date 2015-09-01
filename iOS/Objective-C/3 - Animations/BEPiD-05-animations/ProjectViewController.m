//
//  ProjectViewController.m
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import "ProjectViewController.h"
#import "Project.h"
#import "Task.h"
#import "ProjectsManager.h"
#import "UIView+push.h"

@implementation ProjectViewController {
    __weak IBOutlet NSLayoutConstraint *topSpace;
    __weak IBOutlet UILabel *lblProjectName;
    __weak IBOutlet UITextField *tfProjectName;
    __weak IBOutlet UITextField *tfTaskName;
    __weak IBOutlet TasksTableView *tvTasks;
    __weak IBOutlet UIImageView *ivSettings;
    __weak IBOutlet UIImageView *ivTrash;
    __weak IBOutlet UIImageView *ivDown;

    BOOL _canDragController;

    ProjectsManager* pm;
}

#pragma mark View

- (void)viewDidLoad {
    pm = [ProjectsManager sharedInstance];
    topSpace.constant = self.view.frame.size.height;
    tvTasks.project = self.project;
    tvTasks.tasksDelegate = self;

    [ivTrash setOnPush:@selector(onPushTrash:) toTarget: self withScale:0.75f];
    [ivDown setOnPush:@selector(onPushDown:) toTarget:self withScale:0.75];
    [ivSettings setOnPush:@selector(onPushSettings:) toTarget:self withScale:0.75];
}

- (void)viewWillAppear:(BOOL)animated {
    lblProjectName.text = self.project.name;
    tfProjectName.text = self.project.name;
}

- (void)viewDidAppear:(BOOL)animated {
    [self scrollIntoView];
}

#pragma mark Gestures

- (void) onPushTrash: (PushGestureRecognizer*) gesture {

    if (self.project.tasks.count > 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Delete Project"
                                                        message:@"Are you sure you want to delete this project with all of its tasks?"
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes", nil];
        [alert show];
    }
    else
        [self deleteProject];
}

- (void) onPushDown: (PushGestureRecognizer*) gesture {
    [self scrollDismiss];
}

- (void) onPushSettings: (PushGestureRecognizer*) gesture {
    [self performSegueWithIdentifier:@"show_project_settings" sender:self];
}

#pragma mark Animations

- (void) pushView: (UIView*) view {
    [UIView animateWithDuration:0.2f animations:^{
    }];
}

- (void) scrollIntoView {
    BOOL editProjectName = NO;
    if ([self.project.name isEqualToString:@"New Project"]) {
        tfProjectName.text = @"";
        editProjectName = YES;
    }

    [self scrollToHeight:0 withDuration:0.3f completion:^(BOOL finished){
        if(editProjectName) {
            [tfProjectName becomeFirstResponder];
        }
        else if (self.project.tasks.count <= 0) {
            [tfTaskName becomeFirstResponder];
        }
    }];
}

- (void) scrollDismiss {
    self.view.userInteractionEnabled = NO;
    [self scrollToHeight:self.view.frame.size.height withDuration:0.3f completion:^(BOOL finished){
        [self dismissViewControllerAnimated:NO completion:nil];
        if (self.projectDelegate)
            [self.projectDelegate didDismissProjectView:self];
    }];
}

- (void) scrollToHeight: (int) height withDuration: (float) duration completion:(void (^)(BOOL finished)) completion {
    [self.view.layer layoutIfNeeded];

    topSpace.constant = height;
    [UIView animateWithDuration: duration delay: 0.0f options: UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view.layer layoutIfNeeded];
    } completion:completion];
}

#pragma mark Tasks

- (void) completeTask: (Task*) task {
    [_project.tasks removeObject: task];
    [_project.completedTasks addObject:task];
    [pm save];

    if (self.projectDelegate)
        [self.projectDelegate projectView:self projectUpdated:self.project];
}

- (void) addTaskWithName: (NSString*) name {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

    [_project.tasks insertObject:[[Task alloc] initWithName: name] atIndex:0 ];
    [pm save];

    [tvTasks insertRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];

    if (self.projectDelegate)
        [self.projectDelegate projectView:self projectUpdated:self.project];
}

#pragma mark Alert Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        [self deleteProject];
    }
}

#pragma mark Tasks Delegate

- (void)tasks:(TasksTableView *)tasksTableView didCompleteTask:(Task *)task {
    [self completeTask:task];
}

#pragma mark Table Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _canDragController = NO;
    
    if (topSpace.constant > 100) {
        [self scrollDismiss];
    }
    else {
        [self scrollIntoView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if(!_canDragController)
        return;

    if (topSpace.constant > scrollView.contentOffset.y) {
        topSpace.constant -= scrollView.contentOffset.y;
        scrollView.contentOffset = CGPointZero;
    }
    else {
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y - topSpace.constant);
        topSpace.constant = 0;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [tfTaskName resignFirstResponder];
    _canDragController = YES;
}

#pragma mark Text Field Delegate

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField != tfProjectName)
        return YES;

    if(textField.text.length > 0) {
        self.project.name = textField.text;
        [textField resignFirstResponder];
        if (self.projectDelegate)
            [self.projectDelegate projectView:self projectUpdated:self.project];
    }
    else {
        textField.text = self.project.name;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.text.length > 0) {

        if (textField == tfTaskName) {
            [self addTaskWithName:textField.text];
            textField.text = @"";
        }

        if (textField == tfProjectName) {
            if (self.project.tasks.count <= 0)
                [tfTaskName becomeFirstResponder];
            else
                [textField resignFirstResponder];
        }

        return YES;
    }
    return NO;
}

#pragma mark Private Methods

- (void) deleteProject {
    NSUInteger index = [pm.projects indexOfObject:self.project];
    [pm.projects removeObject:self.project];
    [pm save];
    if (self.projectDelegate)
        [self.projectDelegate projectView:self projectDeletedAt:index];
    [self scrollDismiss];
}

@end
