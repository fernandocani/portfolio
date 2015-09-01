//
//  UIView+ancestors.m
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/5/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import "UIView+ancestors.h"

@implementation UIView(ancestors)

- (id) getAncestorOfType: (Class) ancestorClass {
    id view = [self superview];

    while (view && [view isKindOfClass:ancestorClass] == NO) {
        view = [view superview];
    }
    return view;
}

@end
