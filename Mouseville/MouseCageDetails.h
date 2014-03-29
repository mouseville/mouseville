//
//  MouseCageDetails.h
//  Mouseville
//
//  Created by abhang on 3/24/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MouseCageDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * cage_id;
@property (nonatomic, retain) NSNumber * mouse_id;
@property (nonatomic, retain) NSString * notes;

@end
