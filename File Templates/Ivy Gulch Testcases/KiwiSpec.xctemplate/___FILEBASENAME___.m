//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "Kiwi.h"

SPEC_BEGIN(___FILEBASENAMEASIDENTIFIER___)

describe(@"example", ^{
    context(@"sum", ^{
        it(@"returns the sum of the two numbers", ^{
            [[@(40 + 2) should] equal:@42];
        });
    });
});

SPEC_END