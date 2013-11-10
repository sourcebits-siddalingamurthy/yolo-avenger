//
//  AMGStringconstants.h
//  AMG_API_Testing
//
//  Created by Anand on 30/09/13.
//  Copyright (c) 2013 Anand. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTitleTextFont                  [UIFont fontWithName:@"Arvo-Bold" size:kPointToPixelConversion(6.0f)]
#define kDescriptionTextFont            [UIFont fontWithName:@"Nexa-Book" size:kPointToPixelConversion(5.0f)]
#define kNoOfViewsTextFont              [UIFont fontWithName:@"Nexa-XBold" size:kPointToPixelConversion(4.0f)]
#define kDateTextFont                   [UIFont fontWithName:@"Nexa-XBold" size:kPointToPixelConversion(4.0f)]

#define kTitleTextColor                 [UIColor colorWithRed:60/255.0f green:60/255.0f blue:60/255.0f alpha:1.0f]
#define kCellBackgroundImageInset       UIEdgeInsetsMake(5.0f, 5.0f, 20.0f, 5.0f)
#define kDescriptionTextColor           [UIColor colorWithRed:110/255.0f green:108/255.0f blue:108/255.0f alpha:1.0f]
#define kNumberOfViewsTextColor         [UIColor colorWithRed:108/255.0f green:108/255.0f blue:108/255.0f alpha:1.0f]
#define kDateTextColor                  [UIColor colorWithWhite:160/255.0f alpha:1.0f]


#define kStatus                     @"status"
#define kResponseData               @"Response"
#define kResponseStatusCode         @"status_code"
#define kRequestType                @"ReQuestType"
#define kConnectionIndentifier      @"ConnectionIndentifier"
#define kErrorDescription           @"ErrorString"
#define kErrors                     @"errors"
#define kStatusCode                 @"StatusCode"
#define kResponseMessage            @"message"
#define kerror_code                 @"error_code"
#define KBASEURL                    @"207.204.86.67/4apitestapi"


#define kUsername                   @"Username"
#define kPassword                   @"Password"
#define kLoginsessionId             @"LoginsessionId"

#define kauthenticity_token         @"authenticity_token"
#define kauthenticitytoken          @"authenticitytoken"
#define kfeed_id                    @"feed_id"
#define kcomment                    @"comment"
#define ksince_id                   @"since_id"
#define kmax_idcount                @"max_idcount"
#define kuser_location              @"user_location"
#define kcurrent_location_latitude  @"current_location_latitude"
#define kcurrent_location_longitude @"current_location_longitude"
#define kradius                     @"radius"
#define kpostData                   @"PostData"
#define kparent_category_type       @"parent_category_type"
#define kparent_category_id         @"parent_category_id"
#define kcategory_type              @"category_type"
#define ksearch_text                @"search_text"
#define kentity_id                  @"entity_id"
#define kthought                    @"thought"
#define kquestion_id                @"question_id"
#define kanswer                     @"answer"
#define kcode                       @"code"
#define ksports                     @"sports"
#define kleague                     @"league"
#define kteam                       @"team"
#define kathlete                    @"athlete"
#define kcategory                   @"category"
#define kname                       @"name"


#define kauthenticity_token         @"authenticity_token"
#define kMaxIDCount                 @"max_idcount"              //Modify once pagination is supported
#define kSinceID                    @"sinceID"                  //Modify once pagination is supported
#define kPagenumber                 @"Pagenumber"                  //Modify once pagination is supported
#define kitemsperPage               @"kitemsperPage"                  //Modify once pagination is supported
#define ktime                       @"ktime"                  //Modify once pagination is supported

#define kmiles_in_a_year            @"miles_in_a_year"
#define kmiles_in_month             @"miles_in_month"
#define kmiles_in_week              @"miles_in_week"
#define Kmiles_in_day               @"miles_in_day"
#define kmilesList                  @"kmilesList"

#define kteams_day                  @"teams_day"
#define kteams_month                @"teams_month"
#define kteams_week                 @"teams_week"
#define kteams_year                 @"teams_year"

#define kleague_day                  @"league_day"
#define kleague_month                @"league_month"
#define kleague_week                 @"league_week"
#define kleague_year                 @"league_year"

#define kathlete_day                  @"athlete_day"
#define kathlete_month                @"athlete_month"
#define kathlete_week                 @"athlete_week"
#define kathlete_year                 @"athlete_year"
#define kpoints                       @"points"
#define kRecentMiles                  @"recent_miles"

#define klocations                     @"locations"
#define klocation_id                   @"location_id"
#define klocation_address              @"location_address"
#define klocation_latitude             @"location_latitude"
#define klocation_longitude            @"location_longitude"
#define klocation_name                 @"location_name"
#define klocation_url                  @"location_url"
#define kcurrentLocationUpdated        @"kcurrentLocationUpdated"

#define kcurrentlocationName            @"kcurrentlocationName"
#define kcurrentlocationAddress         @"kcurrentlocationAddress"
#define kcurrentlocationLatitude        @"kcurrentlocationLatitude"
#define kcurrentlocationLongitude       @"kcurrentlocationLongitude"
#define kprofile_picture_url            @"profile_picture_url"
#define ksport_name                     @"sport_name"
#define kleague_name                    @"league_name"
#define kteam_name                     @"team_name"
#define kathlete_name                     @"athlete_name"



#define kFeedData                   @"feed_data"
#define kFeedType                   @"feed_type"
#define kFeedViewCount              @"feed_view_count"
#define kFeedCreationDate           @"feed_creation_date"
#define kFeedID                     @"feed_id"
#define KFeedHTMLData               @"feed_html_data"
#define kFeedPrimaryImage           @"feed_primary_image"
#define kUrl                        @"url"
#define kHeight                     @"height"
#define kWidth                      @"width"
#define kMediaTags                  @"feed_media_tags"
#define kMediaThumbnail             @"media:thumbnail"
#define kMediaGroup                 @"media:group"
#define kMediaContent               @"media:content"
#define kAt                         @"@"
#define kType                       @"type"
#define kMedium                     @"medium"
#define kFeedTitle                  @"feed_title"
#define kFeedSource                 @"feed_source"
#define kFeedAuthor                 @"feed_author"
#define kFeedSubject                @"feed_subject"
#define kFeedSubjectProfileURL      @"feed_subject_profile_url"
#define kFeedModalObjectArray       @"feedModalObjectArray"
#define kwar_chest_medals           @"war_chest_medals"
#define kmedal_subtitle             @"medal_subtitle"
#define kmedal_title                @"medal_title"
#define kid                         @"id"
#define kquestion_id                @"question_id"
#define kanswer                     @"answer"
#define kquestion                   @"question"
#define ktranslatedResponse         @"translatedResponse"
#define kLoading                    @"Loading..."
#define kmessage                    @"message"
#define kmiles                      @"miles"
#define kerror_code                 @"error_code"
#define kisDynamicrefreshEnabled    @"isDynamicrefreshEnabled"
#define kArticleURL                 @"article_url"
#define kFeedTypeUserActivity       @"user_activity"

#define kCategoryName               @"category_name"
#define kCategoryID                 @"category_id"
#define kCategoryImageURLArray      @"category_image_url"

#define kCity                       @"city"
#define kCountry                    @"country"
#define KProfilePictureURL          @"profile_picture_url"
#define kIsBeingTracked             @"is_being_tracked"
#define kUserRelationType           @"user_relation_type"
#define kFriendModelObjectArray     @"friendModelObjectArray"


#define kCommentCount               @"comments_count"
#define kFriendsCount               @"friends_count"
#define kPhotosCount                @"photos_count"
#define kVideosCount                @"videos_count"
#define kIsClaimed                  @"is_claimed"
#define kIsLiked                    @"is_liked"
#define kEntityName                 @"name"
#define kProfilePictureURL          @"profile_picture_url"
#define kResult                     @"result"
#define kSayingText                 @"saying_text"
#define kStats                      @"stats"
#define kEventsInfo                 @"event"


#define kPhotoComments              @"comments"
#define kPhotoLikeCount             @"like_count"
#define kPhotoDate                  @"photo_date"
#define kPhotoDescription           @"photo_description"
#define kPhotoID                    @"photo_id"
#define kPhotoURL                   @"photo_url"
#define kPhotoSayingText            @"saying_text"

#define kClipDictionaryKey          @"clips"
#define kClipVideoURLArray          @"video_urls"
#define kClipVideoCategory          @"clip_category"
#define kLiveVideoURL               @"live_video_url"

#define kClipVideoArrayKey          @"clipVideoArrayKey"
#define kLiveVideoArrayKey          @"liveVideoArraykey"