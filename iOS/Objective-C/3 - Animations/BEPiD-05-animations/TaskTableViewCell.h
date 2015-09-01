//
//  TaskTableViewCell.h
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaskTableViewCell;
@class Task;

@protocol TaskCellDelegate <NSObject>

- (void) taskCell: (TaskTableViewCell*) cell taskCompleted: (Task*) task;

@end

@interface TaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTaskName;
@property (weak, nonatomic) IBOutlet UIImageView *ivCheckBorder;
@property (weak, nonatomic) IBOutlet UIImageView *ivCheckMark;
@property (weak, nonatomic) IBOutlet UIImageView *ivCheck;

@property id<TaskCellDelegate> delegate;

- (void) setTask: (Task*) task;

@end
