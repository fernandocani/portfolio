//
//  ProjectsTableHandler.h
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProjectsTableView;
@class Project;

@protocol ProjectsTableDelegate <NSObject>

- (void) didTapNewProjectOn: (ProjectsTableView*) projectsTableView;
- (void) didTapProject: (Project*) project on: (ProjectsTableView*) projectsTableView;

@end

@interface ProjectsTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property id<ProjectsTableDelegate> projectsDelegate;

- (void) addProject: (Project*) project;
- (void) updateRowForProject: (Project*) project;
- (void) deleteRowForProjectAt: (NSUInteger) index;

@end

