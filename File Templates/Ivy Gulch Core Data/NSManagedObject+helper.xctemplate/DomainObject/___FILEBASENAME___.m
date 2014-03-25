//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___.h"
#import "NSManagedObjectContext+IVGUtils.h"
#import "NSString+IVGUtils.h"
#import "IVGClock.h"

#define ENTITY_NAME @"___VARIABLE_categoryClass:identifier___"

@implementation ___VARIABLE_categoryClass:identifier___ (___VARIABLE_categoryName:identifier___)

+ (id) newWithContext:(NSManagedObjectContext *) context
                error:(NSError **) error;
{
    NSLog(@"%@ newWithContext, entityname:%@", NSStringFromClass(self), ENTITY_NAME);
    ___VARIABLE_categoryClass:identifier___ *result = [context insertNewEntityWithName:ENTITY_NAME];
    result.___VARIABLE_domainObjectId:identifier___ = [NSString UUID];
    NSDate *now = [[IVGClock sharedClock] currentDate];
    result.createdTimestamp = now;
    result.modifiedTimestamp = now;
    return result;
}

@end
