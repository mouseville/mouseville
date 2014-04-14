//
//  Mouse.m
//  Mouseville
//
//  Created by Abhang on 2/15/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "Mouse.h"
#import "Genotype.h"
@implementation Mouse


+(NSString *)getGenotypeString:(MouseDetails *)mouse {
    
    NSString *genstr = @"";
    
    for (Genotype *gen in mouse.genotypes) {
        genstr = [genstr stringByAppendingString:gen.genotype_name];
    }
    
    return genstr;
    
}

-(BOOL) addNewMouse:(NSManagedObjectContext *)managedObjectContext mouseName:(NSString *)mouseName gender:(NSString *)gender genotypes:(NSSet *)genotypes dateOfBirth:(NSDate *)dateOfBirth rackName:(NSString *)rackName cageRow:(NSNumber*)cageRow cageColoumn:(NSNumber*)cageColumn

{

    MouseDetails* mouse = [NSEntityDescription insertNewObjectForEntityForName:@"MouseDetails" inManagedObjectContext:managedObjectContext];
    
    
    NSEntityDescription* rackEntity = [NSEntityDescription entityForName:@"RackDetails" inManagedObjectContext:managedObjectContext];
    NSEntityDescription* cageEntity = [NSEntityDescription entityForName:@"CageDetails" inManagedObjectContext:managedObjectContext];
    
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:rackEntity];
    
    
    NSFetchRequest* fetchRequest2 = [[NSFetchRequest alloc]init];
    
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"rack_name LIKE %@", rackName];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSError* errorRequest = nil;
    NSArray* racks = [managedObjectContext executeFetchRequest:fetchRequest error:&errorRequest];
    
    
    [fetchRequest2 setEntity:cageEntity];
    
    
    
    if(errorRequest)
    {
        NSLog(@"Error requesting rack %@ %@", errorRequest, [errorRequest localizedDescription]);
        return NO;
    }
    
    
    if([racks count] == 0)
    {
        //replace every NSLog with UIAlertView
        NSLog(@"No rack present with the name %@", rackName);
    }
    
    RackDetails* rack ;
    
    for(RackDetails* eachRack in racks)
    {
        if([eachRack.rack_name isEqual:rackName])
        {
            rack = eachRack;
            break;
        }
    }
    
//    NSPredicate* predicate2 = [NSPredicate predicateWithFormat:@"cage_name == %@ AND rack_id == %@", cageName, [rack rack_id]];
//    
//    [fetchRequest2 setPredicate:predicate2];
//    
//    
//    NSArray* cages = [managedObjectContext executeFetchRequest:fetchRequest2 error:&errorRequest];
//    
//    if(errorRequest)
//    {
//        NSLog(@"Error requesting cage %@ %@", errorRequest, [errorRequest localizedDescription]);
//        return  NO;
//    }
//    
//    if([cages count]==0)
//    {
//        NSLog(@"No cage present with the name %@", cageName);
//        return NO;
//    }
//    
//    CageDetails* cage = cages[0];
    
    
    CageDetails* cage;
    
    for(CageDetails* eachCage in rack.cages)
    {
        
        
        if( [eachCage.row_id intValue] == [cageRow intValue] && [eachCage.column_id intValue] == [cageColumn intValue])
        {
            cage = eachCage;
            break;
        }
    }
    
    
    if(cage!=nil)
    {
        mouse.mouse_name = mouseName;
        mouse.gender = gender;
        mouse.birth_date = dateOfBirth;
        mouse.cage_id = cage.cage_id;
        mouse.mouse_id = [self nextMouseId:cage];
        mouse.is_deceased = @"NO";
        mouse.cage_name = cage.cage_name;
        mouse.cageDetails = cage;
       [mouse addMiceFamilyDetails:[self getPotentialParents:cage]];
        
        for(NSString* insertGenotypeString in genotypes)
        {
            Genotype* genotypeEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Genotype" inManagedObjectContext:managedObjectContext];
            
            genotypeEntity.genotype_name = insertGenotypeString;
            
            [mouse addGenotypesObject:genotypeEntity];
      
            
            
        }
        
        
        [cage addMouseDetailsObject:mouse];
        
    }
    
    else
    {
        return NO;
    }
    
    
    if(![managedObjectContext save:&errorRequest])
    {
        NSLog(@"Error saving new mouse details %@ %@", errorRequest, [errorRequest localizedDescription]);
    }
    
    
    return YES;
}

-(MouseDetails*) getMiceForRackCage: (NSManagedObjectContext *)managedObjectContext mouseName:(NSString *)mouseName gender:(NSString *)gender rack:(NSString*) rackName cageRow:(NSNumber*)cageRow cageColumn:(NSNumber*)cageColumn

{
    NSEntityDescription* mouseEntity = [NSEntityDescription entityForName:@"MouseDetails" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:mouseEntity];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"mouse_name LIKE '%@'",mouseName];
    [fetchRequest setPredicate:predicate];
    
    NSError* errorRequest = nil;
    
    NSArray* mouseArray = [managedObjectContext executeFetchRequest:fetchRequest error:&errorRequest];
    
    for(MouseDetails* eachMouse in mouseArray)
    {
        if([eachMouse.mouse_name isEqual:mouseName] && [eachMouse.cageDetails.column_id intValue] == [cageRow intValue] && [eachMouse.cageDetails.row_id intValue] == [cageColumn intValue] && [eachMouse.cageDetails.rackDetails.rack_name isEqual:rackName])
        {
            return eachMouse;
        }
    }
    
    return nil;
    
}





-(NSArray*)getAllDeceasedMice:(NSManagedObjectContext *)managedObjectContext
{
    
    
    NSEntityDescription* mouseDeceasedEntity = [NSEntityDescription entityForName:@"MouseDeceasedDetails" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:mouseDeceasedEntity];
    
    NSError* errorRequest = nil;
    
    NSArray* mouseDeceasedDetails = [managedObjectContext executeFetchRequest:fetchRequest error:&errorRequest];
    
    if(errorRequest==nil)
    {
        return mouseDeceasedDetails;
    }
    else
    {
        
        NSLog(@"Error retreiving deceased mouse %@",[errorRequest localizedDescription]);
        return nil;
        
    }
}


-(NSArray*) miceResult:(NSManagedObjectContext *)managedObjectContext mouseName:(NSString *)mouseName gender:(NSString *)gender genotype:(NSString *)genotype weekRange:(NSArray *)ageRange

{
    NSEntityDescription* mouseEntity = [NSEntityDescription entityForName:@"MouseDetails" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:mouseEntity];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"mouse_name LIKE '%@'",mouseName];
    [fetchRequest setPredicate:predicate];
    
    NSError* errorRequest = nil;
    
    NSArray* mouseArray = [managedObjectContext executeFetchRequest:fetchRequest error:&errorRequest];
    
    if(errorRequest)
    {
        NSLog(@"Error retrieving mouse details getParticularMouse %@ %@",errorRequest, [errorRequest localizedDescription]);
        return  nil;
    }
    
    if([mouseArray count] == 0)
    {
        NSLog(@"Error no such mouse with given mouse name %@",mouseName);
        return  nil;
    }
    
    NSMutableArray* mouseResult = [[NSMutableArray alloc]init];
    
    for(MouseDetails* mouse in mouseArray)
    {
        if([[mouse genotypes] containsObject:genotype ] && ([self getWeeksFromDate:mouse.birth_date]>=[[ageRange firstObject] integerValue] && [self getWeeksFromDate:mouse.birth_date]<=[[ageRange lastObject] integerValue]))
        {
            [mouseResult addObject:mouse];
        }
        
    }
    
    NSArray* result = [[NSArray alloc]initWithArray:mouseResult];
    return result;
    
}

-(MouseDetails*) editMouseDetails:(NSManagedObjectContext *)managedObjectContext mouseDetails:(MouseDetails *)mouseDetails
{
 
    NSEntityDescription* mouseEntity = [NSEntityDescription entityForName:@"MouseDetails" inManagedObjectContext:managedObjectContext];
    
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:mouseEntity];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"mouse_name LIKE '%@'",mouseDetails.mouse_name];
    [fetchRequest setPredicate:predicate];
    
   
    NSError* errorRequest = nil;
    
    NSArray* mouseArray = [managedObjectContext executeFetchRequest:fetchRequest error:&errorRequest];
    
    MouseDetails* mouseToEdit = nil;
    
    for(MouseDetails* individualMouse in mouseArray)
    {
        if(individualMouse.cage_id == mouseDetails.cage_id && individualMouse.cage_name == mouseDetails.cage_name && [individualMouse.mouse_name isEqual:mouseDetails.mouse_name])
        {
            mouseToEdit = individualMouse;
        }
    }
    
    
    if([mouseDetails.is_deceased  isEqual: @"Yes"])
    {
        MouseDeceasedDetails* mouseDeceased = [NSEntityDescription insertNewObjectForEntityForName:@"MouseDeceasedDetails" inManagedObjectContext:managedObjectContext];
        mouseDeceased.mouse_name = mouseDetails.mouse_name;
        mouseDeceased.mouse_id = mouseDetails.mouse_id;
        mouseDeceased.birth_date = mouseDetails.birth_date;
        mouseDeceased.gender = mouseDetails.gender;
        mouseDeceased.genotype = mouseDetails.genotypes;
        mouseDeceased.cage_id = mouseDetails.cage_id;
        mouseDeceased.cage_name = mouseDetails.cage_name;
        mouseDeceased.miceFamilyDetails = mouseDetails.miceFamilyDetails;
        mouseDeceased.is_deceased = @"Yes";
        
        
        [managedObjectContext deleteObject:mouseToEdit];
        
        if(![managedObjectContext save:&errorRequest])
        {
            NSLog(@"Error saving editMouseDetails %@ %@", errorRequest, [errorRequest localizedDescription]);
            return nil;
        }
        
        return nil;

    }
    
    
    mouseToEdit.mouse_name = mouseDetails.mouse_name;
    mouseToEdit.gender = mouseDetails.gender;
    mouseToEdit.genotypes = mouseDetails.genotypes;
    mouseToEdit.birth_date = mouseDetails.birth_date;
    
    if(![managedObjectContext save:&errorRequest])
    {
        NSLog(@"Error saving mouse details %@", [errorRequest localizedDescription]);
        return nil;
    }
    else
    {
        return mouseToEdit;
    }
    
}


-(BOOL) markMousedDeceased:(NSManagedObjectContext *)managedObjectContext mouseDetails:(MouseDetails *)mouseDetails
{
    
    MouseDeceasedDetails* mouseDeceased = [NSEntityDescription insertNewObjectForEntityForName:@"MouseDeceasedDetails" inManagedObjectContext:managedObjectContext];
    mouseDeceased.mouse_name = mouseDetails.mouse_name;
    mouseDeceased.mouse_id = mouseDetails.mouse_id;
    mouseDeceased.birth_date = mouseDetails.birth_date;
    mouseDeceased.gender = mouseDetails.gender;
    mouseDeceased.genotype = mouseDetails.genotypes;
    mouseDeceased.cage_id = mouseDetails.cage_id;
    mouseDeceased.cage_name = mouseDetails.cage_name;
    mouseDeceased.miceFamilyDetails = mouseDetails.miceFamilyDetails;
    mouseDeceased.is_deceased = @"Yes";
    
    
    
    NSError* errorRequest = Nil;
    
    [managedObjectContext deleteObject:mouseDetails];
    
    if(![managedObjectContext save:&errorRequest])
    {
        NSLog(@"Error saving markMouseDeceased %@ %@", errorRequest, [errorRequest localizedDescription]);
        return NO;
    }
    
    return YES;
    
}


-(NSSet*) getPotentialParents:(CageDetails *)cageDetails
{
    
    //mice having age greater than equal to 2 weeks is parent
    
    NSMutableArray* potentialParents = [[NSMutableArray alloc]init];
    
    for(MouseDetails* mouse in cageDetails.mouseDetails)
    {
        if([self getWeeksFromDate:[mouse birth_date]]>=2)
        {
            [potentialParents addObject:mouse];
        }
    }
    
    NSArray* potentialParentsArray = [[NSArray alloc] initWithArray:potentialParents];
    
    NSSet* potentialParentsSet = [NSSet setWithArray:potentialParentsArray] ;
    
    return potentialParentsSet;
    
    
}


-(int) getWeeksFromDate: (NSDate*) date
{
    //NSDateFormatter if format error
    
    NSDate* currentDate = [[NSDate alloc] init];
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit;
    
    NSDateComponents* components = [gregorian components:unitFlags fromDate:date toDate:currentDate options:0];
    
    NSInteger weeks = [components week];
    
    int numberOFWeeks = weeks;
    
    return numberOFWeeks;
}

-(NSNumber*) nextMouseId:(CageDetails *)cageDetails
{
    NSUInteger currentMice = [[cageDetails mouseDetails] count];
    currentMice = currentMice + 1;
    
    NSNumber* nextID = [NSNumber numberWithUnsignedInteger:currentMice];
    return  nextID;
    
}


@end
