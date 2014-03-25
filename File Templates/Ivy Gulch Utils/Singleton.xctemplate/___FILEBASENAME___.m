//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___.h"
 
@implementation ___FILEBASENAMEASIDENTIFIER___
 
+ (id)shared___FILEBASENAMEASIDENTIFIER___;
 {
    static dispatch_once_t predicate;
    static ___FILEBASENAMEASIDENTIFIER___ *instance = nil;
    dispatch_once(&predicate, ^{instance = [[self alloc] init];});
    return instance;
}
 
@end