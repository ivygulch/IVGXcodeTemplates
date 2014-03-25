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

@property (nonatomic,strong,readonly) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic,strong,readonly) NSManagedObjectContext *rootContext;
@property (nonatomic,strong,readonly) NSManagedObjectModel *model;

- (id) initWithUsePrepopulatedIfMissing:(BOOL) usePrepopulatedIfMissing;

@end
