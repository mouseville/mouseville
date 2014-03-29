//
//  LabelCageMapping.h
//  Mouseville
//
//  Created by abhang on 3/24/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LabelCageMapping : NSManagedObject

@property (nonatomic, retain) NSNumber * cage_id;
@property (nonatomic, retain) NSNumber * label_id;

@end
