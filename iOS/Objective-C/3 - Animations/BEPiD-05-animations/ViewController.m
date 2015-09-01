//
//  ViewController.m
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/2/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import "ViewController.h"
#import "ProjectSettingsViewController.h"
#import "ProjectViewController.h"
#import "Project.h"
#import "ProjectsManager.h"

@interface ViewController () {
    __weak IBOutlet ProjectsTableView* projects;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgC;
@property (weak, nonatomic) IBOutlet UIImageView *imgWhite;


@end

@implementation ViewController

#pragma mark ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    projects.projectsDelegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden: YES animated:animated];
    [projects reloadData];
    

}

- (void)viewDidAppear:(BOOL)animated {
    
    
    [UIView animateWithDuration:0.6f delay:0.5f options:UIViewAnimationOptionCurveLinear animations:^{
        
        _imgWhite.alpha = 0.0;
    }completion:nil];

    
    
    
    [UIView animateWithDuration:0.9f delay:0.5f options:UIViewAnimationOptionCurveLinear animations:^{
        
        float x = self.imgC.frame.origin.x;
        float y = self.imgC.frame.origin.y;
        float w = self.imgC.frame.size.width;
        float h = self.imgC.frame.size.height;
        
        self.imgC.frame = CGRectMake(x-w*15,
                                     y-h*15,
                                     w*30,
                                     h*30);
    }completion:nil];
    [self clearProjectSelection];
   
}

#pragma mark Projects Table Delegate

- (void) didTapNewProjectOn:(ProjectsTableView *)projectsTableView {
    Project* project = [[Project alloc] initWithName: @"New Project"];
    ProjectsManager* pm = [ProjectsManager sharedInstance];
    [pm.projects addObject:project];
    [pm save];
    [self didTapProject:project on:projects];
    [projects addProject:project];
}

- (void) didTapProject: (Project*) project on: (ProjectsTableView*) projectsTableView {
    ProjectViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier: @"project_view"];
    vc.project = project;
    vc.projectDelegate = self;
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark Project View Delegate

- (void)projectView:(ProjectViewController *)projectView projectUpdated:(Project *)project {
    [projects updateRowForProject: project];
}

- (void)projectView:(ProjectViewController *)projectView projectDeletedAt:(NSUInteger) index {
    [projects deleteRowForProjectAt:index];
}

- (void)didDismissProjectView:(ProjectViewController *)projectView {
    [self clearProjectSelection];
}

#pragma mark Private

- (void) clearProjectSelection {
    NSIndexPath *indexPath = projects.indexPathForSelectedRow;
    if (indexPath) {
        [projects deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
