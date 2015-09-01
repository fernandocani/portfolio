//
//  TasksTableView.m
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import "TasksTableView.h"
#import "Project.h"
#import "Task.h"
#import "ProjectsManager.h"
#import "UIView+ancestors.h"

@implementation TasksTableView {
    Project* _project;
}

- (void)didMoveToWindow {
    self.dataSource = self;
}

#pragma mark Properties

- (Project*) getProject {
    return _project;
}

- (void) setProject:(Project *)project {
    _project = project;
    [self reloadData];
}

#pragma mark DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_project) return 0;
    return _project.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Task* task = self.project.tasks[indexPath.row];

    TaskTableViewCell* cell = [self dequeueReusableCellWithIdentifier:@"task_cell" forIndexPath:indexPath];

    cell.delegate = self;
    [cell setTask: task];

    return cell;
}

#pragma mark Cells

- (void) deleteCell: (UITableViewCell*) cell {
    NSIndexPath* indexPath = [self indexPathForCell:cell];
    Task* task = _project.tasks[indexPath.row];

    if (self.tasksDelegate) {
        [self.tasksDelegate tasks:self didCompleteTask:task];
    }

    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark Task Delegate

- (void)taskCell:(TaskTableViewCell *)cell taskCompleted:(Task *)task {
    [self deleteCell:cell];
}

@end
