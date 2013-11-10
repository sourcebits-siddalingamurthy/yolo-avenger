//
//  AMGEnums.h
//  AMG_API_Testing
//
//  Created by Anand on 30/09/13.
//  Copyright (c) 2013 Anand. All rights reserved.
//

typedef enum
{
    eSignupRequest=2001,
    eLoginRequest,
    eBrowsefeedsRequest,
    eAddcommentRequest,
    eBrowsecommentsRequest,
    eRewardRequest,
    eWarchestsRequest,
    eLocationsRequest,
    eSubcategoriesRequest,
    eCategoriesRequest,
    eSearchRequest,
    eVideosRequest,
    eCommentsRequest,
    eAddthoughtRequest,
    ePhotosRequest,
    eMilesRequest,
    eFriendsRequest,
    eTrackentityRequest,
    eUnTrackEntityRequest,
    eUserEventsRequest,
    eQuestionsRequest,
    eCheckanswerRequest,
    eTapinRequest,
    eSportsPreferenceRequest,
    eLeaguePreferenceRequest,
    eTeamPreferenceRequest,
    eAthletePreferenceRequest,
    eSavePreferenceRequest,
    eEntityLikeRequest,
    eEntityDislikeRequest,
    eDiscoverFriendsRequest,
    eCategoryListRequest,
    eEntityProfileRequest,
    ePhotosListRequest,
    eVideosListRequest
}eAMGWebRequestType;


typedef enum
{
	eHTTPResoponseOK = 200,
	eHTTPResoponseCreated = 201,
	eHTTPResoponseEmpty	= 204,
	eHTTPResoponseMovedTemporarily = 302,
	eHTTPResoponseBadRequest = 400,
	eHTTPResoponseUnAuthorized = 401,
	eHTTPResoponseForbidden = 403,
	eHTTPResoponseNotFound = 404,
	eHTTPResoponseConflictOrDuplicate = 409,
	eHTTPResoponseGone = 410,
	eHTTPResoponseInternalError = 500,
	eHTTPResoponseInvalidParameter = 501,
	eHTTPResoponseInvalidSession = 503,
	eHTTPResponseInvalidChannel = 504,
	eHTTPResponseInvalidLocation = 505,
	eHTTPResponseNoDataFound = 506,
	
	eHTTPResponseDeviceAlreadyRegistered = 510,
	eHTTPResponseUserAlreadyRegistered = 511,
	eHTTPResponseInvalidUsernameOrPassword = 512,
	eHTTPResponseInvalidUser = 513,
	eHTTPResponseTransactionID = 514,
	eHTTPResponseInvalidFileType = 515,
	eHTTPResponseFileSizeExceeded = 516,
	eHTTPResponseTextIsTooLong = 517,
	eHTTPResponseInvalidPostID = 518,
	eHTTPResponseUserAlreadyFollowing = 519,
	eHTTPResponseInvalidBlogger = 520,
	eHTTPResponseUserNotFollowingBlogger = 522,
	eHTTPResponseInvalidMSISDN = 523,
	eHTTPResponseInvalidPassword = 524,
	eHTTPResponseYouAreNotAllowedToFollowThisBlogger = 525,
	eHTTPResponseWrongAuthenticationDetails = 532
}eHTTPResponseStatusCode;

typedef enum
{
    eInvalidcredentials = 10434,
    etokenExpired = 10433,
    etokenInvalid = 10432,
    eunprocessableRequest = 10422,
    einvalidInputformat = 10412,
    eunAuthorized = 10401,
    eresourceNotfound = 10404,
    einputnotAcceptable = 10406,
    ealreadyRegistered = 10409,
    eunKnownStatus = 10000,
    esuccess = 200,

}eAPIStatuscode;

//Enum for Refresh type
typedef enum
{
    eStaticRefresh,
    eDynamicRefresh
}eRefreshtype;

typedef enum
{
    eAthlete = 5,
    eSports = 2,
    eLeague = 3,
    eTeam = 4,
}eCategorytype;
