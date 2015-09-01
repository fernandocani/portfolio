//
//  UIView+ancestors.h
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/5/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView(ancestors)

- (id) getAncestorOfType: (Class) ancestorClass;

@end
