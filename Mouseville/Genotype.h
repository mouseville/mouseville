//
//  Genotype.h
//  Mouseville
//
//  Created by abhang on 4/6/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MouseDeceasedDetails, MouseDetails;

@interface Genotype : NSManagedObject

@property (nonatomic, retain) NSString * genotype_name;
@property (nonatomic, retain) MouseDeceasedDetails *mouseDeceasedDetails;
@property (nonatomic, retain) MouseDetails *mouseDetails;

@end
