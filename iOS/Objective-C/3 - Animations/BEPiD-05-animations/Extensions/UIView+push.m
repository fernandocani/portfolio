//
//  UIView+push.m
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/5/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import "UIView+push.h"

@implementation PushGestureRecognizer
@end

@implementation UIView(push)

-(void)setOnPush:(SEL)onPush toTarget: (id) target withScale: (float) pushScale {
    PushGestureRecognizer* pushRecognizer = [[PushGestureRecognizer alloc] initWithTarget:self action:@selector(onPushAction:)];

    pushRecognizer.pushScale = pushScale;
    pushRecognizer.onPush = onPush;
    pushRecognizer.target = target;

    [self addGestureRecognizer:pushRecognizer];
}

- (void) onPushAction: (PushGestureRecognizer*) gesture {
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, gesture.pushScale, gesture.pushScale);

    [gesture.target performSelector:gesture.onPush withObject:gesture afterDelay:0];

    [UIView animateWithDuration:0.2f animations:^{
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    }];
}

@end
