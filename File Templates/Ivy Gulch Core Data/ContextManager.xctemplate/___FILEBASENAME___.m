//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___.h"
#import "___VARIABLE_classPrefix:identifier___ModelConstants.h"
#import "IVGUtils.h"
 
@interface ___FILEBASENAMEASIDENTIFIER___()
@property (nonatomic,strong,readwrite) NSManagedObjectContext *rootContext;
@property (nonatomic,strong) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic,strong) NSManagedObjectModel *model;
@end
 
@implementation ___FILEBASENAMEASIDENTIFIER___
 
- (id) initWithUsePrepopulatedIfMissing:(BOOL) usePrepopulatedIfMissing;
{
    if ((self = [super init])) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:k___VARIABLE_classPrefix:identifier___ModelName withExtension:@"momd"];
        _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

        NSString *destinationPath = [self databasePath];
        NSError *error;
        if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath] && usePrepopulatedIfMissing) {
            NSString *sourcePath = [[NSBundle mainBundle] pathForResource:k___VARIABLE_classPrefix:identifier___ModelName ofType:@"sqlite"];
            if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error]) {
                [self showFatalError:error];
                return nil;
            }
        }
        NSURL *storeURL = [[NSURL alloc] initFileURLWithPath:destinationPath isDirectory:NO];

        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];

        NSDictionary *options = [NSDictionary
                                 dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                                 nil];
        if (![_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            [self showFatalError:error];
            return nil;
        }

        _rootContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_rootContext setRetainsRegisteredObjects:NO];
        _rootContext.undoManager = [[NSUndoManager  alloc] init];
        [_rootContext.undoManager setLevelsOfUndo:10];
        if(![[_rootContext undoManager] isUndoRegistrationEnabled]) {
            [[_rootContext  undoManager] enableUndoRegistration];
        }

        [_rootContext setPersistentStoreCoordinator:_coordinator];
    }

    return self;
}

- (NSString *) databasePath;
{
    NSString *sqliteFilename = [k___VARIABLE_classPrefix:identifier___ModelName stringByAppendingString:@".sqlite"];
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [libraryDirectory stringByAppendingPathComponent:sqliteFilename];
}

- (void) showFatalError:(NSError *) error;
{
    NSString *errorMessage = [NSString stringWithFormat:@"There was a fatal error in the application\n%@\n%@", [error localizedDescription], [error userInfo]];
    NSLog(@"errorMessage: %@", errorMessage);
    UIAlertView* alertView = [[UIAlertView alloc] 
                              initWithTitle:@"Persistence Error"
                              message:errorMessage
                              delegate:nil
                              cancelButtonTitle:@"Close"
                              otherButtonTitles:nil];
    [alertView show];
}


@end
