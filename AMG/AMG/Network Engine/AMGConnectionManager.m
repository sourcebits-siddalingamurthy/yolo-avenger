//
//  AMGConnectionManager.m
//  AMG_API_Testing
//
//  Created by Anand on 30/09/13.
//  Copyright (c) 2013 Anand. All rights reserved.
//

#import "AMGConnectionManager.h"

@implementation AMGConnectionManager

- (id) init
{
    self = [super init];
    if(self != nil)
    {
        mConnections = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (AMGConnectionManager *) sharedConnectionManager
{
    static dispatch_once_t pred;
    static AMGConnectionManager *sharedInstance = nil;
    dispatch_once(&pred, ^
                  {
                      sharedInstance = [[AMGConnectionManager alloc] init];
                  });
    
    return sharedInstance;

}


-(void)addOperation:(MKNetworkOperation*)inRequest withConnectionIdentifier:(NSString*)inIdentifier
{
	@synchronized(self)
	{
		[mConnections setObject:inRequest forKey:inIdentifier];
	}
}


-(void)cancelAllconnections
{
	@synchronized(self)
	{
		[[mConnections allValues] makeObjectsPerformSelector:@selector(cancel)];
		[mConnections removeAllObjects];
	}
}

-(void)canceltheConnectionWithconnectionIdentifier:(NSString*)inIdentifier
{
	@synchronized(self)
	{
		if(nil != inIdentifier)
		{
            MKNetworkOperation *the_operation = [mConnections objectForKey:inIdentifier];
			[mConnections removeObjectForKey:inIdentifier];
			[the_operation cancel];
		}
	}
}

-(void)removeRequestWithIdentifier:(NSString*)inIdentifier
{
	@synchronized(self)
	{
		if(nil != inIdentifier)
		{
			[mConnections removeObjectForKey:inIdentifier];
		}
	}
}

@end
