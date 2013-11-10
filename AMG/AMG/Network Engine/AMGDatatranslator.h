//
//  AMGDatatranslator.h
//  AMG_API_Testing
//
//  Created by Anand on 30/09/13.
//  Copyright (c) 2013 Anand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkOperation.h"

@interface AMGDatatranslator : NSObject
{
    
}
+ (NSMutableDictionary *)getparsedJSONDataForString:(NSString*)inresponsedata error:(NSError**)outError forOperation:(MKNetworkOperation*)inOperation;

@end
