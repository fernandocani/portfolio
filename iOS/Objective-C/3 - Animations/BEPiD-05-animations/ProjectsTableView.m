//
//  ProjectsTableHandler.m
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import "ProjectsTableView.h"
#import "ProjectTableViewCell.h"
#import "ProjectsManager.h"
#import "Project.h"
#import "ProjectSettingsViewController.h"

@implementation ProjectsTableView {
    ProjectsManager* pm;
}

- (void)didMoveToWindow {
    pm = [ProjectsManager sharedInstance];
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark Public Methods

- (void) addProject:(Project *)project {
    NSIndexPath* path = [self indexPathForProject:project];
    [self insertRowsAtIndexPaths:@[path] withRowAnimation:YES];
}

- (void) updateRowForProject:(Project *)project {
    NSIndexPath* indexPath = [self indexPathForProject: project];
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void) deleteRowForProjectAt: (NSUInteger) index {
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return pm.projects.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row >= pm.projects.count)
        return [self createNewProjectCellFor:indexPath];

    return [self projectCellFor: indexPath];
}

#pragma mark Gestures

- (void) onTapProject: (UITapGestureRecognizer*) tap {
    UITableViewCell* cell = (UITableViewCell*)tap.view;
    NSIndexPath* indexPath = [self indexPathForCell:cell];
    Project* project = pm.projects[indexPath.row];

    [self selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];

    id<ProjectsTableDelegate> delegate = self.projectsDelegate;
    if(delegate)
        [delegate didTapProject:project on:self];

    [self pushDown: cell];
}

- (void) onTapNewProject: (UITapGestureRecognizer*) tap {
    UITableViewCell* cell = (UITableViewCell*)tap.view;
    NSIndexPath* indexPath = [self indexPathForCell:cell];

    [self selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];

    id<ProjectsTableDelegate> delegate = self.projectsDelegate;
    if(delegate)
        [delegate didTapNewProjectOn: self];

    [self pushDown: cell];
}

#pragma mark Cells

- (UITableViewCell*) createNewProjectCellFor: (NSIndexPath*) indexPath {
    UITableViewCell* cell = [self dequeueReusableCellWithIdentifier:@"new_project_cell" forIndexPath:indexPath];

    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapNewProject:)];
    [cell addGestureRecognizer:tapRecognizer];

    return [self fadeInCell:cell];
}

- (UITableViewCell*) projectCellFor: (NSIndexPath*) indexPath {
    Project* project = pm.projects[indexPath.row];

    ProjectTableViewCell* cell = [self dequeueReusableCellWithIdentifier:@"project_cell" forIndexPath:indexPath];
    cell.lblProjectName.text = project.name;
    cell.lblProjectTasks.text = project.tasks.count == 1? @"1 Task" :
    [NSString stringWithFormat:@"%lu Tasks", project.tasks.count];

    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:1.0f green:0.5f blue:0.0f alpha:0.25f]];
    [cell setSelectedBackgroundView:bgColorView];

    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapProject:)];
    [cell addGestureRecognizer:tapRecognizer];

    return [self fadeInCell:cell];
}

#pragma mark Animations

- (UITableViewCell*) fadeInCell: (UITableViewCell*) cell {
    cell.alpha = 0;
    [UIView animateWithDuration:1.0f animations:^{
        cell.alpha = 1;
    }];
    return cell;
}

- (void) pushDown: (UITableViewCell*) cell {
    cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.98f, 0.98f);
    [UIView animateWithDuration:0.2f animations:^{
        cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    }];
}

#pragma mark Private Methods

- (NSIndexPath*) indexPathForProject: (Project*) project {
    return [NSIndexPath indexPathForRow:[pm.projects indexOfObject:project] inSection:0];
}

@end
