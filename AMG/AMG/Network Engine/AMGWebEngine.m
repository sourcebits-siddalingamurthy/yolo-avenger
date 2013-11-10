//
//  AMGWebEngine.m
//  AMG_API_Testing
//
//  Created by Anand on 30/09/13.
//  Copyright (c) 2013 Anand. All rights reserved.
//

#import "AMGWebEngine.h"
#import "AMGEnums.h"
#import "AMGConnectionManager.h"
#import "AMGDatatranslator.h"
#import "AMGWebEngineConstants.h"
#import "ASINSStringAdditions.h"
#import "AMGStringconstants.h"

#define kminutesinYear (3600*24*365)

@implementation AMGWebEngine

+ (AMGWebEngine*) defaultWebEngine
{
    static dispatch_once_t pred;
    static AMGWebEngine *sharedInstance = nil;
    dispatch_once(&pred, ^
    {
        sharedInstance = [[AMGWebEngine alloc] init];
    });
    
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    
    if (self)
    {
        _networkEngine = [[MKNetworkEngine alloc] initWithHostName:KBASEURL];

    }
    return self;
}

- (NSString *)sendPOSTRequestToWebServerBlock:(NSString*)relativePath
                                         body:(NSDictionary*)inData
                                  requestType:(eAMGWebRequestType)requestType
                                  contextInfo:(id)contextInfo
                                responseBlock:(AMGWebEngineResponseBlock)inResponseBlock
                                   errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
	
 
    MKNetworkOperation *op = [_networkEngine operationWithPath:relativePath
                                                        params:inData
                                                    httpMethod:@"POST"];
    
    op.requestType = requestType;
    
    if(contextInfo)
    {
        op.contextInfo = contextInfo;
    }

    
    NSString *the_connectionID = nil;
    the_connectionID = [NSString stringWithNewUUID];
    [op setConnectionIdentifier:the_connectionID];
    
    [[AMGConnectionManager sharedConnectionManager] addOperation:op  withConnectionIdentifier:the_connectionID];
    
    [op onCompletion:^(MKNetworkOperation *operation)
     {
         //NSObject<WIWebEngineDelegate> *delegate = [operation delegate];
         
         NSError *the_error = nil;
         NSString *the_responsestring = [operation responseString];
         NSLog(@"response string =%@",the_responsestring);
         NSDictionary *the_parsedcontents = [AMGDatatranslator getparsedJSONDataForString:the_responsestring error:&the_error forOperation:operation];
         NSString *the_compltedoperationIdentifier = [operation connectionIdentifier];
         [[AMGConnectionManager sharedConnectionManager] removeRequestWithIdentifier:the_compltedoperationIdentifier];
        
         if(the_error==nil)
         {
             inResponseBlock(the_parsedcontents);
         }
         else
         {
             NSLog(@"PARSER ERROR");
         }
         
     } onError:^(NSError *error)
     {
         
         NSLog(@"%@", error);
         inErrorBlock(error);
     }];
    
    [_networkEngine enqueueOperation:op];
    
    return the_connectionID;
}



- (NSString *)sendMultipartPOSTRequestToWebServer:(NSString*)relativePath
											 body:(NSMutableDictionary*)inParams
                                       imagedata :(NSDictionary*)requestBody
									  requestType:(eAMGWebRequestType)requestType
									  contextInfo:(id)contextInfo
                                    responseBlock:(AMGWebEngineResponseBlock)inResponseBlock
                                       errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    
    MKNetworkOperation *op = [_networkEngine operationWithPath:relativePath
                                                        params:inParams
                                                    httpMethod:@"POST"];

//    [op setIsMultipartRequest:YES];
    
    NSString *the_imagepath = [requestBody objectForKey:@"image"];
    [op addFile:the_imagepath forKey:@"vProfileImageUrl"];
       
    
    // setFreezable uploads your images after connection is restored!
    [op setFreezable:YES];
    op.requestType = requestType;
    NSString *the_connectionID = nil;
    the_connectionID = [NSString stringWithNewUUID];
    [op setConnectionIdentifier:the_connectionID];
    [[AMGConnectionManager sharedConnectionManager] addOperation:op  withConnectionIdentifier:the_connectionID];
    
    [op onCompletion:^(MKNetworkOperation *operation)
     {
         NSError *the_error = nil;
         NSString *the_reposestring = [operation responseString];
         NSDictionary *the_parsedcontents = [AMGDatatranslator getparsedJSONDataForString:the_reposestring error:&the_error forOperation:operation];
         NSLog(@"the_parsedcontents =%@",[the_parsedcontents description]);
         NSLog(@"response string =%@",the_reposestring);
         
         
        NSString *the_compltedoperationIdentifier = [operation connectionIdentifier];
         [[AMGConnectionManager sharedConnectionManager] removeRequestWithIdentifier:the_compltedoperationIdentifier];
         
         if(the_error==nil)
         {
             inResponseBlock(the_parsedcontents);
         }
         else
         {
             NSLog(@"PARSER ERROR");

         }
         
     }
             onError:^(NSError *error)
     {
         NSLog(@"%@", error);
         inErrorBlock(error);
     }];
    [_networkEngine enqueueOperation:op];
    
    return the_connectionID;
}

- (NSString *)sendGETRequestToWebServer:(NSString*)relativePath
                                         body:(NSMutableDictionary*)inData
                                  requestType:(eAMGWebRequestType)requestType
                                  contextInfo:(id)contextInfo
                                responseBlock:(AMGWebEngineResponseBlock)inResponseBlock
                                   errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
	
    MKNetworkOperation *op = [_networkEngine operationWithPath:relativePath
                                                        params:nil
                                                    httpMethod:@"GET"];
    
    op.requestType = requestType;
    
    NSString *the_connectionID = nil;;
    the_connectionID = [NSString stringWithNewUUID];
    [op setConnectionIdentifier:the_connectionID];
    [[AMGConnectionManager sharedConnectionManager] addOperation:op  withConnectionIdentifier:the_connectionID];
    
    [op onCompletion:^(MKNetworkOperation *operation)
     {
         NSError *the_error = nil;
         NSString *the_reposestring = [operation responseString];
         NSDictionary *the_parsedcontents = [AMGDatatranslator getparsedJSONDataForString:the_reposestring error:&the_error forOperation:operation];
         NSLog(@"the_parsedcontents =%@",[the_parsedcontents description]);
         NSLog(@"response string =%@",the_reposestring);
         
         
         NSString *the_compltedoperationIdentifier = [operation connectionIdentifier];
         [[AMGConnectionManager sharedConnectionManager] removeRequestWithIdentifier:the_compltedoperationIdentifier];
         
         if(the_error==nil)
         {
             inResponseBlock(the_parsedcontents);
         }
         else
         {
             NSLog(@"PARSER ERROR");

         }
     }
        onError:^(NSError *error)
     {
         
         NSLog(@"%@", error);
         inErrorBlock(error);

     }];
    [_networkEngine enqueueOperation:op];
    
    return the_connectionID;
}



- (NSString *)sendPOSTRequestToWebServerBlock:(NSString*)relativePath
                                         body:(NSDictionary*)inData 
                         postDataEncodingType:(MKNKPostDataEncodingType) encodingType
                                  requestType:(eAMGWebRequestType)requestType
                                  contextInfo:(id)contextInfo
                                responseBlock:(AMGWebEngineResponseBlock)inResponseBlock
                                   errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
	
    
    MKNetworkOperation *op = [_networkEngine operationWithPath:relativePath
                                                        params:inData
                                                    httpMethod:@"POST"];
    
    op.requestType = requestType;
    
    if(contextInfo)
    {
        op.contextInfo = contextInfo;
    }
    
    
    NSString *the_connectionID = nil;
    the_connectionID = [NSString stringWithNewUUID];
    [op setConnectionIdentifier:the_connectionID];
    
    [op setPostDataEncoding:encodingType];
    
    [[AMGConnectionManager sharedConnectionManager] addOperation:op  withConnectionIdentifier:the_connectionID];
    
    [op onCompletion:^(MKNetworkOperation *operation)
     {
         //NSObject<WIWebEngineDelegate> *delegate = [operation delegate];
         
         NSError *the_error = nil;
         NSString *the_responsestring = [operation responseString];
         NSLog(@"response string =%@",the_responsestring);
         NSDictionary *the_parsedcontents = [AMGDatatranslator getparsedJSONDataForString:the_responsestring error:&the_error forOperation:operation];
         NSString *the_compltedoperationIdentifier = [operation connectionIdentifier];
         [[AMGConnectionManager sharedConnectionManager] removeRequestWithIdentifier:the_compltedoperationIdentifier];
         
         if(the_error==nil)
         {
             inResponseBlock(the_parsedcontents);
         }
         else
         {
             NSLog(@"PARSER ERROR");
         }
         
     } onError:^(NSError *error)
     {
         
         NSLog(@"%@", error);
         inErrorBlock(error);
     }];
    
    [_networkEngine enqueueOperation:op];
    
    return the_connectionID;
}


#pragma mark - Common Methods

-(void)cancelAllconnections
{
    [_networkEngine cancelAllOperations];
}

#pragma mark - API methods (POST Requests)
- (NSString*)sendLoginRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_relativeURL = @"user/login";
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendPOSTRequestToWebServerBlock:the_relativeURL body:inDict requestType:eLoginRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendAddcommentRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_relativeURL = @"newsfeed/addcomment";
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendPOSTRequestToWebServerBlock:the_relativeURL body:inDict requestType:eAddcommentRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}


- (NSString*)sendgetLocationsListRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"map/locations/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendPOSTRequestToWebServerBlock:the_relativeURL body:inDict requestType:eLocationsRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendgetsubCategoriesListRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"category/subcategories/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendPOSTRequestToWebServerBlock:the_relativeURL body:inDict requestType:eSubcategoriesRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendgetCategoriesListRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"category/categories/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendPOSTRequestToWebServerBlock:the_relativeURL body:inDict requestType:eCategoriesRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}


- (NSString*)sendSearchlocationRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"category/search/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendPOSTRequestToWebServerBlock:the_relativeURL body:inDict requestType:eSearchRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}


- (NSString*)sendAddthoughtRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_entityID =inDict[kentity_id];
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/entity/addthought/authenticitytoken/%@/entity_id/%@",the_authentication_token,the_entityID];    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendPOSTRequestToWebServerBlock:the_relativeURL body:inDict requestType:eAddthoughtRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendCheckAnswerRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/question/checkanswer/authenticitytoken/%@",the_authentication_token];    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendPOSTRequestToWebServerBlock:the_relativeURL body:inDict requestType:eCheckanswerRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendTapinRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/tapin/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendPOSTRequestToWebServerBlock:the_relativeURL body:inDict requestType:eTapinRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendgetLeaguepreferenceRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/preference/league/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendPOSTRequestToWebServerBlock:the_relativeURL body:inDict requestType:eLeaguePreferenceRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}
- (NSString*)sendgetteampreferenceRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/preference/team/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendPOSTRequestToWebServerBlock:the_relativeURL body:inDict requestType:eTeamPreferenceRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}
- (NSString*)sendgetAtheletepreferenceRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/preference/athlete/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendPOSTRequestToWebServerBlock:the_relativeURL body:inDict requestType:eAthletePreferenceRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendSavepreferenceRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/preference/add/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendPOSTRequestToWebServerBlock:the_relativeURL body:inDict requestType:eSavePreferenceRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}


//Category list Request
- (NSString*)sendCategoryListRequestForLocationWithLatitude:(double)latitude
                                                  longitude:(double)longitude
                                               regionRadius:(CGFloat)radius
                                              responseBlock:(AMGWebEngineResponseBlock)inResponseBlock
                                                 errorBlock:(AMGWebEngineErrorBlock)inErrorBlock {
    
    
    //    NSString *latitudeValueString = [[NSString alloc] initWithFormat:@"%f", latitude];
    //    NSString *longitudeValueString = [[NSString alloc] initWithFormat:@"%f", longitude];
    //    NSString *radiusValueString = [[NSString alloc] initWithFormat:@"%f", radius];
    
    NSNumber *latitudeValueNumber = [[NSNumber alloc] initWithDouble:latitude];
    NSNumber *longitudeValueNumber = [[NSNumber alloc] initWithDouble:longitude];
    NSNumber *radiusValueNumber = [[NSNumber alloc] initWithFloat:radius];
    
    NSDictionary *userLocationInfoDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                latitudeValueNumber, kcurrent_location_latitude,
                                                longitudeValueNumber, kcurrent_location_longitude,
                                                radiusValueNumber, kradius,
                                                nil];
    NSDictionary *requestBodyDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:userLocationInfoDictionary, kuser_location, nil];
    
    NSString *authenticationToken = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *categoryListRequestURL = [[NSString alloc] initWithFormat:@"/category/search/authenticitytoken/%@", authenticationToken];
    
    NSString *connectionID = [self sendPOSTRequestToWebServerBlock:categoryListRequestURL
                                                              body:requestBodyDictionary
                                                       requestType:eCategoryListRequest
                                                       contextInfo:nil
                                                     responseBlock:inResponseBlock
                                                        errorBlock:inErrorBlock];
    return connectionID;
    
}


#pragma mark - API methods (GET Requests)
- (NSString*)sendBrowsefeedsRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSNumber *pagenumber = [inDict objectForKey:kPagenumber];
    NSNumber *pageCount = [inDict objectForKey:kitemsperPage];
    NSString *the_time = [inDict objectForKey:ktime];
    int time_param = 0;
    if(the_time)
    {
        time_param = the_time.floatValue * kminutesinYear;
    }
    
    NSString *the_relativeURL = [NSString  stringWithFormat:@"newsfeed/browsefeeds/authenticitytoken/%@/pagenumber/%d/pagesize/%d/time/%d",the_authentication_token,pagenumber.intValue,pageCount.intValue,time_param];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eBrowsefeedsRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
    
	return the_connectionID;
}

- (NSString*)sendBrowsecommentRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_feedID = inDict[kfeed_id];
    NSString *the_sinceID = inDict[ksince_id];
    NSString *the_max_idcount = inDict[kmax_idcount];
    NSString *the_relativeURL = [NSString stringWithFormat:@"newsfeed/browsecomments/authenticitytoken/%@/feed_id/%@/since_id/%@/max_idcount/%@",the_authentication_token,the_feedID,the_sinceID,the_max_idcount];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eBrowsecommentsRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];

	return the_connectionID;
}

- (NSString*)sendGetrewardsListRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"reward/won/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eRewardRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendWarchestsRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSNumber *pagenumber = [inDict objectForKey:kPagenumber];
    NSNumber *pageCount = [inDict objectForKey:kitemsperPage];
    
    NSString *the_relativeURL = [NSString stringWithFormat:@"/reward/warchests/authenticitytoken/%@/pagenumber/%d/pagesize/%d",the_authentication_token,pagenumber.intValue,pageCount.intValue];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eWarchestsRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendgetVideosListRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_entityID =inDict[kentity_id];
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/entity/videos/authenticitytoken/%@/entity_id/%@",the_authentication_token,the_entityID];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eVideosRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendgetCommentsRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_entityID =inDict[kentity_id];
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/entity/comments/authenticitytoken/%@/entity_id/%@",the_authentication_token,the_entityID];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eCommentsRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendgetPhotosRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_entityID =inDict[kentity_id];
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/entity/photos/authenticitytoken/%@/entity_id/%@",the_authentication_token,the_entityID];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:ePhotosRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendgetMilesRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/miles/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eMilesRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendgetFriendsListRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
   
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/user/friends/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eFriendsRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendtrackentityRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_entityID =inDict[kentity_id];
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/user/track/authenticitytoken/%@/id/%@",the_authentication_token,the_entityID];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eTrackentityRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)senduntrackentityRequestwithInfo:(NSMutableDictionary *)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_entityID =inDict[kentity_id];
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/user/untrack/authenticitytoken/%@/id/%@",the_authentication_token,the_entityID];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eTrackentityRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}


- (NSString*)sendgetUserEventsRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/user/events/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eUserEventsRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendgetQuestionsRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/question/daily/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eQuestionsRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendgetSportpreferenceRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/preference/sports/authenticitytoken/%@",the_authentication_token];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eSportsPreferenceRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
}

- (NSString*)sendmarkAsreadRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock
{
    NSString *the_authentication_token = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *the_feedID = [inDict objectForKey:kfeed_id];
    NSString *the_relativeURL = [NSString stringWithFormat:@"/newsfeed/readfeed/authenticitytoken/%@/feed_id/%@",the_authentication_token,the_feedID];
    NSLog(@"Request URL:%@",the_relativeURL);
	NSString *the_connectionID = [self sendGETRequestToWebServer:the_relativeURL body:inDict requestType:eSportsPreferenceRequest contextInfo:nil responseBlock:inResponseBlock errorBlock:inErrorBlock];
	return the_connectionID;
 
}

//Entity Like Get Request
- (NSString*)sendEntityLikeRequestWithEntityID:(NSString *)entityID responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock {
    
    NSString *authenticationToken = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *entityLikeRequestURL = [[NSString alloc] initWithFormat:@"/entity/like/authenticitytoken/%@/entity_id/%@", authenticationToken, entityID];
    NSLog(@"Request URL: %@", entityLikeRequestURL);
    NSString *connectionID = [self sendGETRequestToWebServer:entityLikeRequestURL
                                                        body:nil
                                                 requestType:eEntityLikeRequest
                                                 contextInfo:nil
                                               responseBlock:inResponseBlock
                                                  errorBlock:inErrorBlock];
    
    return connectionID;
}

//Entity Dislike Get Request
- (NSString*)sendEntityDislikeRequestWithEntityID:(NSString *)entityID responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock {
    NSString *authenticationToken = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *entityDislikeRequestURL = [[NSString alloc] initWithFormat:@"/entity/dislike/authenticitytoken/%@/entity_id/%@", authenticationToken, entityID];
    NSLog(@"Request URL: %@", entityDislikeRequestURL);
    NSString *connectionID = [self sendGETRequestToWebServer:entityDislikeRequestURL
                                                        body:nil
                                                 requestType:eEntityDislikeRequest
                                                 contextInfo:nil
                                               responseBlock:inResponseBlock
                                                  errorBlock:inErrorBlock];
    
    return connectionID;
}

//Discover Friends Request
- (NSString*)sendDiscoverFriendsRequestWithResponseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock {
    NSString *authenticationToken = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *discoverFriendsRequestURL = [[NSString alloc] initWithFormat:@"/user/discoverfriends/authenticitytoken/%@", authenticationToken];
//    NSLog(@"Request URL: %@", discoverFriendsRequestURL);
    NSString *connectionID = [self sendGETRequestToWebServer:discoverFriendsRequestURL
                                                        body:nil
                                                 requestType:eDiscoverFriendsRequest
                                                 contextInfo:nil
                                               responseBlock:inResponseBlock
                                                  errorBlock:inErrorBlock];
    
    return connectionID;
}






-(NSString *)sendProfileDetailRequestForEntityWithID:(NSInteger) entityID
                                       responseBlock:(AMGWebEngineResponseBlock)inResponseBlock
                                          errorBlock:(AMGWebEngineErrorBlock)inErrorBlock {
    NSString *authenticationToken = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *profileDetailRequestURLString = [[NSString alloc] initWithFormat:@"/entity/profile/authenticitytoken/%@/entity_id/%d", authenticationToken, entityID];
    
    NSString *connectionID = [self sendGETRequestToWebServer:profileDetailRequestURLString
                                                        body:nil
                                                 requestType:eEntityProfileRequest
                                                 contextInfo:nil
                                               responseBlock:inResponseBlock
                                                  errorBlock:inErrorBlock];
    return connectionID;
}



-(NSString*) sendPhotosListRequestEntityWithID:(NSInteger)entityID
                                 responseBlock:(AMGWebEngineResponseBlock)inResponseBlock
                                    errorBlock:(AMGWebEngineErrorBlock)inErrorBlock {
    
    NSString *authenticationToken = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *profileDetailRequestURLString = [[NSString alloc] initWithFormat:@"/entity/photos/authenticitytoken/%@/entity_id/%d", authenticationToken, entityID];
    
    NSString *connectionID = [self sendGETRequestToWebServer:profileDetailRequestURLString
                                                        body:nil
                                                 requestType:ePhotosListRequest
                                                 contextInfo:nil
                                               responseBlock:inResponseBlock
                                                  errorBlock:inErrorBlock];
    return connectionID;

}

-(NSString*) sendVideosListRequestEntityWithID:(NSInteger)entityID responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock{
    NSString *authenticationToken = [[NSUserDefaults standardUserDefaults] objectForKey:kauthenticity_token];
    NSString *profileDetailRequestURLString = [[NSString alloc] initWithFormat:@"/entity/videos/authenticitytoken/%@/entity_id/%d", authenticationToken, entityID];
    
    NSString *connectionID = [self sendGETRequestToWebServer:profileDetailRequestURLString
                                                        body:nil
                                                 requestType:eVideosListRequest
                                                 contextInfo:nil
                                               responseBlock:inResponseBlock
                                                  errorBlock:inErrorBlock];
    return connectionID;
}
@end
