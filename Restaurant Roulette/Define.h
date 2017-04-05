//
//  Define.h
//  BeaconApp
//
//  Created by Luokey on 7/2/15.
//  Copyright (c) 2015 Luokey. All rights reserved.
//

#ifndef BeaconApp_Define_h
#define BeaconApp_Define_h


#define UBER_CLIENT_ID                                      @"BokFerOAGUSN7WVN2kkN5un812B29ddX"
#define UBER_CLIENT_SECRET                                  @"kqSAD7AkmroPAOPRmooHzuOq_X9f6IhSnnse0wwI"
#define UBER_SERVER_TOKEN                                   @"kSvqYCJRMshy5YGId3a-rsD8xZGn-G5OnYMRrrjW"

#define LYFT_CLIENT_ID                                      @"tc6bMTlUTKn1"
//#define LYFT_CLIENT_SECRET                                  @"EnlHgXbzc35CFYb4KRQT31LifItdQ8B4"
#define LYFT_CLIENT_SECRET                                  @"SANDBOX-EnlHgXbzc35CFYb4KRQT31LifItdQ8B4"// for Lyft Sandbox


#define Documents_Folder                                    [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

#define ScreenBounds                                        [UIScreen mainScreen].bounds


// Notification Keys
#define Notification_UserLocationUpdated                    @"UserLocationUpdated"
#define Notification_UserLocationUpdateFailed               @"UserLocationUpdateFailed"
#define Notification_LocationAuthorizationStatusChanged     @"LocationAuthorizationStatusChanged"
#define Notification_LocationSettingUpdated                 @"LocationSettingUpdated"


// Uber endpoints
#define UBER_URL                                            @"https://api.uber.com/v1"
#define UBER_URL_SANDBOX                                    @"https://sandbox-api.uber.com/v1"
#define LYFT_URL                                            @"https://api.lyft.com"

#define UBER_ENDPOINT_PRODUCTS                              [UBER_URL_SANDBOX stringByAppendingPathComponent:@"products"]
#define UBER_ENDPOINT_ESTIMATES_PRICE                       [UBER_URL_SANDBOX stringByAppendingPathComponent:@"estimates/price"]
#define UBER_ENDPOINT_ESTIMATES_TIME                        [UBER_URL_SANDBOX stringByAppendingPathComponent:@"estimates/time"]

#define LYFT_ENDPOINT_BEARER_TOKEN                          [LYFT_URL stringByAppendingPathComponent:@"oauth/token"]
#define LYFT_ENDPOINT_COST                                  [LYFT_URL stringByAppendingPathComponent:@"v1/cost"]


#define key_Authorization                                   @"Authorization"
#define key_SANDBOX                                         @"SANDBOX-"
#define key_Token                                           @"Token"

#define key_access_token                                    @"access_token"
#define key_access_token_url                                @"access_token_url"
#define key_authorization_code                              @"authorization_code"
#define key_authorize_url                                   @"authorize_url"
#define key_base_url                                        @"base_url"
#define key_code                                            @"code"
#define key_cost_estimates                                  @"cost_estimates"
#define key_client_credentials                              @"client_credentials"
#define key_client_id                                       @"client_id"
#define key_client_secret                                   @"client_secret"
#define key_currency                                        @"currency"
#define key_currency_code                                   @"currency_code"
#define key_destination                                     @"destination"
#define key_display_name                                    @"display_name"
#define key_distance                                        @"distance"
#define key_duration                                        @"duration"
#define key_end_lat                                         @"end_lat"
#define key_end_latitude                                    @"end_latitude"
#define key_end_lng                                         @"end_lng"
#define key_end_longitude                                   @"end_longitude"
#define key_estimate                                        @"estimate"
#define key_estimated_cost_cents_max                        @"estimated_cost_cents_max"
#define key_estimated_cost_cents_min                        @"estimated_cost_cents_min"
#define key_estimated_distance_miles                        @"estimated_distance_miles"
#define key_estimated_duration_seconds                      @"estimated_duration_seconds"
#define key_expires_in                                      @"expires_in"
#define key_grant_type                                      @"grant_type"
#define key_high_estimate                                   @"high_estimate"
#define key_invalid_client                                  @"invalid_client"
#define key_invalid_grant                                   @"invalid_grant"
#define key_invalid_request                                 @"invalid_request"
#define key_invalid_scope                                   @"invalid_scope"
#define key_low_estimate                                    @"low_estimate"
#define key_pickup                                          @"pickup"
#define key_prices                                          @"prices"
#define key_primetime_confirmation_token                    @"primetime_confirmation_token"
#define key_primetime_percentage                            @"primetime_percentage"
#define key_product_id                                      @"product_id"
#define key_public                                          @"public"
#define key_redirect_uri                                    @"redirect_uri"
#define key_refresh_token                                   @"refresh_token"
#define key_response_type                                   @"response_type"
#define key_ride_type                                       @"ride_type"
#define key_scope                                           @"scope"
#define key_server_error                                    @"server_error"
#define key_server_token                                    @"server_token"
#define key_start_lat                                       @"start_lat"
#define key_start_latitude                                  @"start_latitude"
#define key_start_lng                                       @"start_lng"
#define key_start_longitude                                 @"start_longitude"
#define key_state                                           @"state"
#define key_surge_multiplier                                @"surge_multiplier"
#define key_temporarily_unavailable                         @"temporarily_unavailable"
#define key_token                                           @"token"
#define key_token_type                                      @"token_type"

#define key_prices                                          @"prices"
#define key_prices                                          @"prices"
#define key_prices                                          @"prices"
#define key_prices                                          @"prices"
#define key_prices                                          @"prices"



typedef enum LyftButtonColor {
    LyftButtonColorBlack = 0,
    LyftButtonColorWhite = 1,
    LyftButtonColorBlackHighlighted = 2,
    LyftButtonColorWhiteHighlighted = 3
}
LyftButtonColor;


#endif
