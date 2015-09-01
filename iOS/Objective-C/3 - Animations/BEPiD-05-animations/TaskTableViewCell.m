//
//  TaskTableViewCell.m
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import "TaskTableViewCell.h"
#import "Task.h"
#import "ProjectViewController.h"
#import "UIView+ancestors.h"

@implementation TaskTableViewCell {
    Task* _task;
    float _dragX;
    UITouch* _dragTouch;
    __weak IBOutlet NSLayoutConstraint *labelLeft;
}

#pragma mark View

- (void) setTask:(Task *)task {
    _task = task;
    self.lbTaskName.text = task.name;
    self.tintColor = [UIColor orangeColor];

    self.ivCheckBorder.hidden = NO;
    self.ivCheckMark.hidden = NO;
    self.ivCheck.hidden = YES;

    self.ivCheckMark.alpha = 0.0f;
    labelLeft.constant = 0;

    self.ivCheck.tintAdjustmentMode =
    self.ivCheckMark.tintAdjustmentMode =
    self.ivCheckBorder.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;

    [self setupGestures];
}

#pragma mark Gestures

- (void) setupGestures {
    if(self.gestureRecognizers.count <= 0) {
        UITapGestureRecognizer* checkRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCheckToCompleteTask:)];
        [self.ivCheckBorder addGestureRecognizer:checkRecognizer];
    }
}

- (void) onCheckToCompleteTask: (UITapGestureRecognizer*) gesture {
    [self animateCheck];
}

#pragma mark Animations

- (void) animateCheck {
    self.ivCheckMark.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.3f, 0.3f);

    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.ivCheckMark.alpha = 1;
        self.ivCheckBorder.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.75f, 0.75f);
    } completion:nil];
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.ivCheckMark.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.8f, 1.8f);
    } completion:nil];


    [UIView animateWithDuration:0.15f delay:0.15f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.ivCheckBorder.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    } completion:nil];
    [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.ivCheckMark.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    } completion: ^(BOOL finished){
        [self notifyCompletion];
    }];
}

- (void) updateManualCheckAnimation {
    float completion = labelLeft.constant / 100;
    if (completion > 1)
        completion = 1;
    float timeEquivalent = completion * 0.55;

    self.ivCheck.hidden = YES;
    self.ivCheckBorder.hidden =
    self.ivCheckMark.hidden = NO;

    if(timeEquivalent < 0.3f) {
        if (timeEquivalent < 0.15){
            float value15_1 = [self normalize:timeEquivalent / 0.15f];

            self.ivCheckMark.alpha = value15_1;
            float borderScale = 1 - (value15_1 * 0.25f);
            self.ivCheckBorder.transform = CGAffineTransformScale(CGAffineTransformIdentity, borderScale, borderScale);
        }
        else {
            self.ivCheckMark.alpha = 1.0f;

            float value15_2 = [self normalize:(timeEquivalent - 0.15f) / 0.15f];
            float borderScale = 0.75f + (value15_2 * 0.25f);
            self.ivCheckBorder.transform = CGAffineTransformScale(CGAffineTransformIdentity, borderScale, borderScale);
        }

        float value3 = [self normalize:timeEquivalent / 0.3f];

        float checkScale = 0.3f + (1.8f - 0.3f) * value3;
        self.ivCheckMark.transform = CGAffineTransformScale(CGAffineTransformIdentity, checkScale, checkScale);
    }
    else{
        self.ivCheckBorder.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        
        if (timeEquivalent < 0.55f) {

            float value4 = [self normalize:(timeEquivalent - 0.3f) / 0.25f];
            float checkScale = 1.8f - 0.8f * value4;
            self.ivCheckMark.transform = CGAffineTransformScale(CGAffineTransformIdentity, checkScale, checkScale);
        }
        else {
            self.ivCheckMark.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
            /*self.ivCheck.hidden = NO;
             self.ivCheckBorder.hidden =
             self.ivCheckMark.hidden = YES;*/
        }
    }
}

- (float) normalize: (float) value {
    if(value < 0)
        return 0;
    if(value > 1)
        return 1;
    return value;
}

- (void) finishDrag: (BOOL) completeTask {
    float duration = completeTask? 0.25f : 0.1f;

    [UIView animateWithDuration:duration delay: 0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.ivCheckBorder.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        self.ivCheckMark.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        self.ivCheckMark.alpha = completeTask? 1.0f : 0.0f;

    } completion:^(BOOL finished){
        if(completeTask)
            [self notifyCompletion];
    }];

    [self.layer layoutIfNeeded];
    labelLeft.constant = completeTask? self.frame.size.width : 0;
    [UIView animateWithDuration: duration delay: 0.0f options: UIViewAnimationOptionCurveEaseIn animations:^{
        [self.layer layoutIfNeeded];
    } completion:nil];
}

#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch* touch in touches) {
        _dragTouch = touch;
        _dragX = [touch locationInView:self].x - labelLeft.constant;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch* touch in touches) {
        if (touch != _dragTouch)
            continue;

        float currentX = [touch locationInView:self].x;
        float change = currentX - _dragX;

        if (labelLeft.constant + change >= 0) {
            labelLeft.constant = change;
        }
        else {
            labelLeft.constant = 0;
        }
        if (change >= 2) {
            TasksTableView *scroll = [self getAncestorOfType:[TasksTableView class]];
            scroll.scrollEnabled = NO;
        }
        [self updateManualCheckAnimation];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    TasksTableView *scroll = [self getAncestorOfType:[TasksTableView class]];
    scroll.scrollEnabled = YES;
    [self finishDrag:labelLeft.constant > 100];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self finishDrag:NO];
}

#pragma mark Delegate

- (void) notifyCompletion {
    if (self.delegate) {
        [self.delegate taskCell:self taskCompleted:_task];
    }
}

@end
