//
//  Project.h
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject

@property NSMutableArray* tasks;
@property NSMutableArray* completedTasks;
@property NSString* name;

- (instancetype)initWithName: (NSString*) name;

- (void)encodeWithCoder: (NSCoder*) encoder;
- (id) initWithCoder: (NSCoder*) decoder;

@end
