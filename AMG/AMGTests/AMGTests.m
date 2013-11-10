//
//  AMGTests.m
//  AMGTests
//
//  Created by Siddalingamurthy on 10/11/13.
//  Copyright (c) 2013 Sourcebit Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AMGWebEngine.h"
#import "AMGStringconstants.h"

@interface AMGTests : XCTestCase

@end

@implementation AMGTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLogin
{
    
    AMGWebEngine *the_sharedEngine = [AMGWebEngine defaultWebEngine];
    __block BOOL hasCalledBack = NO;
    
    NSMutableDictionary *infoDictionary = [@{kUsername:@"sportma",kPassword:@"pass"} mutableCopy];
    [the_sharedEngine sendLoginRequestwithInfo:infoDictionary responseBlock:^(NSDictionary *responseDict)
     {
         
         NSDictionary *API_response = [responseDict objectForKey:kResponseData];
         XCTAssertNotNil(API_response, @"Response is Nil! There is some problem with server or your requet!");
         
       
         
         
         
         NSString *the_loginsessionID = [API_response objectForKey:kauthenticity_token];
         XCTAssertNotNil(the_loginsessionID, @"No Authentication Token in the Response");
         
         
         if(the_loginsessionID)
         {
             [[NSUserDefaults standardUserDefaults] setObject:the_loginsessionID forKey:kauthenticity_token];
             [[NSUserDefaults standardUserDefaults] synchronize];
         }
         hasCalledBack = YES;

         
     }errorBlock:^(NSError *error)
     {
         NSLog(@"error = %@",[error description]);
         XCTFail(@"sendLoginRequestwithInfo failed");
         hasCalledBack = YES;
     }];
    
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:10];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    if (!hasCalledBack)
    {
        XCTFail(@"I know this will fail, thanks");
    }

    
    
   // XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
