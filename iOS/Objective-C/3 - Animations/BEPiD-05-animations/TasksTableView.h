//
//  TasksTableView.h
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskTableViewCell.h"

@class Project;
@class TasksTableView;
@class Task;

@protocol TasksTableDelegate <NSObject>

- (void) tasks: (TasksTableView*) tasksTableView didCompleteTask: (Task*) task;

@end

@interface TasksTableView : UITableView<UITableViewDelegate, UITableViewDataSource, TaskCellDelegate>

@property (getter=getProject, setter=setProject:) Project* project;
@property id<TasksTableDelegate> tasksDelegate;

@end
