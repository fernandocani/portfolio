//
//  ProjectsManager.m
//  BEPiD-05-animations
//
//  Created by João Vitor P. Moraes on 4/4/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import "ProjectsManager.h"
#import "Project.h"

@implementation ProjectsManager

+ (id)sharedInstance {
    static ProjectsManager* instance = nil;
    static dispatch_once_t once;

    dispatch_once(&once, ^{
        instance = [[ProjectsManager alloc] init];
    });

    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self reload];
    }
    return self;
}

- (void) reload {
    _projects = [[NSMutableArray alloc] init];

    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSData* savedData = [userDefaults valueForKey:@"projects"];

    if(savedData) {
        NSArray* savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
        for (Project* project in savedArray) {
            [_projects addObject:project];
        }
    }
}

- (void) save {
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:_projects];

    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:@"projects"];
    [userDefaults synchronize];
}

@end
