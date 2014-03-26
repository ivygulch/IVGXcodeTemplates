//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___.h"
#import "___VARIABLE_classPrefix:identifier___Constants.h"
#import "___VARIABLE_classPrefix:identifier___NotificationConstants.h"
#import "___VARIABLE_classPrefix:identifier___Model.h"
#import "___VARIABLE_classPrefix:identifier___ModelConstants.h"
#import "___VARIABLE_classPrefix:identifier___ContextManager.h"
#import "NSManagedObjectContext+IVGUtils.h"
#import "NSArray+IVGUtils.h"
#import "IVGUtils.h"
 
@interface ___FILEBASENAMEASIDENTIFIER___()
@property (nonatomic,strong) ___VARIABLE_classPrefix:identifier___ContextManager *contextManager;
@property (nonatomic,strong,readwrite) NSString *baseDirectory;
@end
 
@implementation ___FILEBASENAMEASIDENTIFIER___
 
+ (id) shared___FILEBASENAMEASIDENTIFIER___;
 {
    static dispatch_once_t predicate;
    static ___FILEBASENAMEASIDENTIFIER___ *instance = nil;
    dispatch_once(&predicate, ^{instance = [[self alloc] init];});
    return instance;
}

- (id) init;
{
    if ((self = [super init])) {
        _contextManager = [[___VARIABLE_classPrefix:identifier___ContextManager alloc] init];

        [self addObservers];
    }
    return self;
}

- (void) dealloc;
{
    [self removeObservers];
}

- (void) addObservers;
{
}

- (void) removeObservers;
{
}

#pragma mark - session methods

- (NSString *) baseDirectory;
{
    if (_baseDirectory == nil) {
        _baseDirectory = [[NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES) lastObject] stringByDeletingLastPathComponent];
    }
    return _baseDirectory;
}

#pragma mark - context methods

- (NSManagedObjectContext *) rootContext;
{
    return [self.contextManager rootContext];
}

- (NSManagedObjectContext *) newChildContext;{
    return [self newChildContextWithParentContext:self.rootContext];
}
- (NSManagedObjectContext *) newChildContextWithParentContext:(NSManagedObjectContext *) context;
{
    NSManagedObjectContext *localContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    localContext.parentContext = context;
    return localContext;
}

- (void) saveRootContext;
{
    [self saveContext:self.rootContext];
}

- (void) saveContext:(NSManagedObjectContext *) context;
{
    [self saveContext:context recursively:NO];
}

- (void) saveContext:(NSManagedObjectContext *) context recursively:(BOOL) recursively;
{
    NSError *error;
    NSManagedObjectContext *contextToSave = context;
    BOOL doneSaving = NO;
    while (!doneSaving) {
        if ([contextToSave save:&error]) {
            contextToSave = recursively ? contextToSave.parentContext : nil;
            doneSaving = (contextToSave == nil);
        } else {
            [self handleContextError:error];
            doneSaving = YES;
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Abort application");
    abort();
}

- (void) handleContextError:(NSError *) error;
{
    NSLog(@"Context error: %@", [error localizedDescription]);
    NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
    if([detailedErrors count] > 0) {
        for(NSError* detailedError in detailedErrors) {
            NSLog(@"DetailedError: %@", [detailedError userInfo]);
        }
    } else {
        NSLog(@"%@", [error userInfo]);
    }
}

#pragma mark - core data utility methods

- (NSArray *) fetchEntities:(NSString *) entityName withContext:(NSManagedObjectContext *) context sortProperty:(NSString *) sortProperty sortAscending:(BOOL) sortAscending;
{
    return [self fetchEntities:entityName withContext:context predicate:nil sortProperty:sortProperty sortAscending:sortAscending];
}

- (NSArray *) fetchEntities:(NSString *) entityName withContext:(NSManagedObjectContext *) context predicate:(id) stringOrPredicate sortProperty:(NSString *) sortProperty sortAscending:(BOOL) sortAscending;
{
    NSArray *sortDescriptors = nil;
    if (sortProperty != nil) {
        sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortProperty ascending:sortAscending]];
    }
    return [context fetchObjectsForEntityName:entityName
                                withPredicate:stringOrPredicate
                                   properties:nil
                              sortDescriptors:sortDescriptors
                                        error:nil];
}

- (id) fetchEntity:(NSString *) entityName withContext:(NSManagedObjectContext *) context predicate:(id)stringOrPredicate;
{
    return [self fetchEntity:entityName withContext:context predicate:stringOrPredicate sortProperty:nil sortAscending:NO];
}

- (id) fetchEntity:(NSString *) entityName withContext:(NSManagedObjectContext *) context predicate:(id)stringOrPredicate sortProperty:(NSString *) sortProperty sortAscending:(BOOL) sortAscending;
{
    NSArray *sortDescriptors = nil;
    if (sortProperty != nil) {
        sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortProperty ascending:sortAscending]];
    }
    NSArray *queryResults = [context
                             fetchObjectsForEntityName:entityName
                             withPredicate:stringOrPredicate
                             properties:nil
                             sortDescriptors:sortDescriptors
                             error:nil];
    return [queryResults objectAtIndex:0 outOfRange:nil];
}

- (void) faultObject:(id) managedObject withContext:(NSManagedObjectContext *) context;
{
    [context refreshObject:managedObject mergeChanges:NO];
}

- (BOOL) deleteEntity:(NSManagedObject *)object withContext:(NSManagedObjectContext *) context error:(NSError **) error;
{
    NSManagedObject *objectToDelete = [context objectWithID:object.objectID];
    [context deleteObject:objectToDelete];
    return [context save:error];
}

@end
