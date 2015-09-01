//
//  Project.m
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import "Project.h"

@implementation Project

- (instancetype)initWithName: (NSString*) name
{
    self = [super init];
    if (self) {
        _name = name;
        _tasks = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.name = [decoder decodeObjectForKey:@"name"];
        self.tasks = [decoder decodeObjectForKey:@"tasks"];
        self.completedTasks = [decoder decodeObjectForKey:@"completedTasks"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject: self.name forKey:@"name"];
    [encoder encodeObject: self.tasks forKey:@"tasks"];
    [encoder encodeObject:self.completedTasks forKey:@"completedTasks"];
}

@end
