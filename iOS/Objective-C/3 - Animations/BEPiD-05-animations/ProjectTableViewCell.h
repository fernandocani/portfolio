//
//  ProjectTableViewCell.h
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblProjectName;
@property (weak, nonatomic) IBOutlet UILabel *lblProjectTasks;

@end
