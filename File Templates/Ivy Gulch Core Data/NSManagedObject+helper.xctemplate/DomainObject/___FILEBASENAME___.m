//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___.h"
#import "NSManagedObjectContext+IVGUtils.h"

#define ENTITY_NAME @"___VARIABLE_categoryClass:identifier___"

@implementation ___VARIABLE_categoryClass:identifier___ (___VARIABLE_categoryName:identifier___)

+ (id) newWithContext:(NSManagedObjectContext *) context
     updateTimestamps:(BOOL) updateTimestamps
                error:(NSError **) error;
{
    NSLog(@"%@ newWithContext, entityname:%@", NSStringFromClass(self), ENTITY_NAME);
    return [self insertEntityWithName:ENTITY_NAME updateTimestamps:updateTimestamps context:context];
}

@end
