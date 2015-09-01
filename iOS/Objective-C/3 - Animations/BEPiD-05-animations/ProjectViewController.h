//
//  ProjectViewController.h
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TasksTableView.h"

@class Project;
@class ProjectViewController;

@protocol ProjectViewDelegate <NSObject>

- (void) projectView: (ProjectViewController*) projectView projectUpdated: (Project*) project;
- (void) projectView: (ProjectViewController*) projectView projectDeletedAt: (NSUInteger) index;
- (void) didDismissProjectView: (ProjectViewController*) projectView;

@end

@interface ProjectViewController : UIViewController<UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, TasksTableDelegate>

@property Project* project;
@property id<ProjectViewDelegate> projectDelegate;

@end
