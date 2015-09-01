//
//  ProjectsManager.h
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectsManager : NSObject

+ (id) sharedInstance;

@property (readonly) NSMutableArray* projects;

- (void) save;

@end
