//
//  AMGWebEngine.h
//  AMG_API_Testing
//
//  Created by Anand on 30/09/13.
//  Copyright (c) 2013 Anand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkEngine.h"
#import "AMGWebEngineConstants.h"

@interface AMGWebEngine : NSObject
{
    MKNetworkEngine *_networkEngine;
}

+ (AMGWebEngine*) defaultWebEngine;

- (void)cancelAllconnections;

//POST Requests
- (NSString*)sendLoginRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendAddcommentRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetLocationsListRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetsubCategoriesListRequestwithInfo:( NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetCategoriesListRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendSearchlocationRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendAddthoughtRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendCheckAnswerRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendTapinRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetLeaguepreferenceRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetteampreferenceRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetAtheletepreferenceRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendSavepreferenceRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;


//GET Requests
- (NSString*)sendBrowsefeedsRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendBrowsecommentRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendGetrewardsListRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendWarchestsRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetVideosListRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetCommentsRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetPhotosRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetMilesRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetFriendsListRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendtrackentityRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)senduntrackentityRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetUserEventsRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetQuestionsRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendgetSportpreferenceRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendmarkAsreadRequestwithInfo:(NSMutableDictionary*)inDict responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendEntityLikeRequestWithEntityID:(NSString *)entityID responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendEntityDislikeRequestWithEntityID:(NSString *)entityID responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendDiscoverFriendsRequestWithResponseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
- (NSString*)sendCategoryListRequestForLocationWithLatitude:(double)latitude longitude:(double)longitude regionRadius:(CGFloat)radius responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
-(NSString*)sendProfileDetailRequestForEntityWithID:(NSInteger)entityID responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
-(NSString*) sendPhotosListRequestEntityWithID:(NSInteger)entityID responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
-(NSString*) sendVideosListRequestEntityWithID:(NSInteger)entityID responseBlock:(AMGWebEngineResponseBlock)inResponseBlock errorBlock:(AMGWebEngineErrorBlock)inErrorBlock;
@end
