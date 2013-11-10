//
//  AMGConnectionManager.h
//  AMG_API_Testing
//
//  Created by Anand on 30/09/13.
//  Copyright (c) 2013 Anand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkOperation.h"

@interface AMGConnectionManager : NSObject
{
    NSMutableDictionary             *mConnections;
}

+ (AMGConnectionManager *) sharedConnectionManager;
-(void)addOperation:(MKNetworkOperation*)inRequest withConnectionIdentifier:(NSString*)inIdentifier;
-(void)removeRequestWithIdentifier:(NSString*)inIdentifier;
-(void)cancelAllconnections;
-(void)canceltheConnectionWithconnectionIdentifier:(NSString*)inIdentifier;

@end
