//
//  Task.h
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property NSString* name;

- (instancetype)initWithName: (NSString*) name;

- (id)initWithCoder:(NSCoder *)decoder;
- (void)encodeWithCoder:(NSCoder *)encoder;

@end
