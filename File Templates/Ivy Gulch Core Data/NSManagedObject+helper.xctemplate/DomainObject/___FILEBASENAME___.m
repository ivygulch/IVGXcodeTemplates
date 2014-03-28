//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___.h"
#import "NSManagedObjectContext+IVGUtils.h"
#import "___VARIABLE_classPrefix:identifier___Model.h"
#import "___VARIABLE_classPrefix:identifier___ModelConstants.h"
#import "NSManagedObject+IVGUtils.h"
#import "NSString+IVGUtils.h"
#import "IVGClock.h"

#define ENTITY_NAME kIVGOMEntityName____VARIABLE_categoryClass:identifier___

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

- (NSString *) description;
{
    return [NSString stringWithFormat:@"%@(%@)", NSStringFromClass([self class]), self.___VARIABLE_domainObjectId:identifier___];
}

- (void) willSave
{
    if (![self isDeleted]) {
        [self setPrimitiveValue:[[IVGClock sharedClock] currentDate] forKey:@"modifiedTimestamp"];
    }
    [super willSave];
}

#pragma mark - KVO methods

- (void)awakeFromInsert;
{
    [self addKeyPathObservers];
}

- (void)awakeFromFetch;
{
    [self addKeyPathObservers];
}

- (void)addKeyPathObservers;
{
/*
// example
    [self addObserverBlock:^(id managedObject, NSString *keyPath, id oldValue, id newValue) {
        if (newValue) {
            [managedObject ensureLocationsHasValue:newValue];
        }
    } forKeyPath:@"PROPERTY_NAME"];
*/
}

- (void)willTurnIntoFault;
{
    [self removeObserverBlocksForAllKeyPaths];
}

#pragma mark - collection methods

/*
// example
- (void) addItem:(Item *) item;
{
    NSMutableSet *items = [self.items mutableCopy];
    [items addObject:item];
    self.items = items;
}

- (void) removeItem:(Item *) item;
{
    NSMutableSet *items = [self.items mutableCopy];
    [items removeObject:item];
    self.items = items;
}
*/

@end
