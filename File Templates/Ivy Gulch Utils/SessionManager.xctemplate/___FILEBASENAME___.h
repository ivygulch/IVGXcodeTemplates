//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ___FILEBASENAMEASIDENTIFIER___ : NSObject

@property (nonatomic,strong,readonly) NSManagedObjectContext *rootContext;
@property (nonatomic,strong,readonly) NSString *baseDirectory;

+ (id) shared___FILEBASENAMEASIDENTIFIER___;

- (void) saveRootContext;
- (void) saveContext:(NSManagedObjectContext *) context;
- (void) saveContext:(NSManagedObjectContext *) context recursively:(BOOL) recursively;
- (NSManagedObjectContext *) newChildContext;
- (NSManagedObjectContext *) newChildContextWithParentContext:(NSManagedObjectContext *) context;

- (NSArray *) fetchEntities:(NSString *) entityName withContext:(NSManagedObjectContext *) context sortProperty:(NSString *) sortProperty sortAscending:(BOOL) sortAscending;
- (NSArray *) fetchEntities:(NSString *) entityName withContext:(NSManagedObjectContext *) context predicate:(id) stringOrPredicate sortProperty:(NSString *) sortProperty sortAscending:(BOOL) sortAscending;
- (id) fetchEntity:(NSString *) entityName withContext:(NSManagedObjectContext *) context predicate:(id)stringOrPredicate;
- (id) fetchEntity:(NSString *) entityName withContext:(NSManagedObjectContext *) context predicate:(id)stringOrPredicate sortProperty:(NSString *) sortProperty sortAscending:(BOOL) sortAscending;
- (void) faultObject:(id) managedObject withContext:(NSManagedObjectContext *) context;


@end
