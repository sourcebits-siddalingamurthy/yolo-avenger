//
//  AMGDatatranslator.m
//  AMG_API_Testing
//
//  Created by Anand on 30/09/13.
//  Copyright (c) 2013 Anand. All rights reserved.
//

#import "AMGDatatranslator.h"
#import "SBJSON.h"
#import "AMGStringconstants.h"


@implementation AMGDatatranslator
+ (NSMutableDictionary *)getparsedJSONDataForString:(NSString*)inresponsedata error:(NSError**)outError forOperation:(MKNetworkOperation*)inOperation
{
    NSMutableDictionary *the_retDict = nil;
	NSString *responseStr = inresponsedata;
    switch ([inOperation requestType])
	{
        case eLoginRequest:
        {
            int statusCode = [inOperation HTTPStatusCode];
            NSError *the_parser_error = nil;
            NSString *the_statusCode = [NSString stringWithFormat:@"%d",statusCode];
            NSString *the_errorString = nil;
            NSString *the_requestType = [NSString stringWithFormat:@"%d",inOperation.requestType];
            SBJSON *the_parser = [SBJSON new];
            if(inresponsedata)
            {
                NSDictionary *API_response = [the_parser objectWithString:responseStr error:&the_parser_error];
                NSString *the_loginsessionID = [API_response objectForKey:kauthenticity_token];
                if(the_loginsessionID)
                {
                    [[NSUserDefaults standardUserDefaults] setObject:the_loginsessionID forKey:kauthenticity_token];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                NSNumber * the_API_Statuscode = [API_response objectForKey:kerror_code];
                if(!the_API_Statuscode)
                {
                    the_API_Statuscode = [NSNumber numberWithInt:esuccess];
                }
                the_retDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:the_API_Statuscode,kerror_code,the_requestType,kRequestType,the_statusCode,kStatusCode,API_response,kResponseData,nil];
            }
            else
            {
                if (outError != NULL)
                    *outError = the_parser_error;
                the_retDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:the_requestType,kRequestType,the_statusCode,kStatusCode,the_errorString,kErrorDescription,nil];
            }
            
        }
            break;

            
            default:
            break;
            
    }
    
    return the_retDict;
}

@end
