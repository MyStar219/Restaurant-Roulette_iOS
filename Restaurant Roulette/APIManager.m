//
//  APIManager.m
//  TaxiApp
//
//  Created by Luokey on 4/11/16.
//  Copyright © 2016 Luokey. All rights reserved.
//

#import "APIManager.h"

@interface APIManager ()

@property (strong, nonatomic) NSString* lyftAccessToken;

@end

@implementation APIManager

+ (APIManager*)sharedManager {
    
    static APIManager* _sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

+ (NSString*)base64EncodedStringFromString:(NSString*)string {
    NSData *data = [NSData dataWithBytes:[string UTF8String] length:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger length = [data length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *)[data bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        static uint8_t const kAFBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length ? kAFBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
        output[idx + 3] = (i + 2) < length ? kAFBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
}

- (AFHTTPRequestOperationManager*)operationManager {
    
    AFHTTPRequestOperationManager* operationManager = [AFHTTPRequestOperationManager manager];
    
    // test code to mark json format
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [operationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:
//                                                                    @"application/x-www-form-urlencoded",
//                                                                    @"application/json",
//                                                                    @"text/plain",
//                                                                    @"text/html",
//                                                                    nil]];
    
    //    if (self.apiToken)
    //        [operationManager.requestSerializer setValue:self.apiToken forHTTPHeaderField:key_apitoken];
    
    return operationManager;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (NSString*)jsonStringWithJsonDict:(NSDictionary*)jsonDict {
    NSString* jsonString = @"";
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:nil];
    if (jsonData)
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

//- (void)getToken {
//    NSDictionary* params = @{key_client_id: UBER_CLIENT_ID,
//                             key_client_secret: UBER_CLIENT_SECRET,
//                             key_grant_type: @"",
//                             key_end_longitude: @(endLongitude)
//                             };
//    
//    AFHTTPRequestOperationManager* operationManager = [self operationManager];
//    [operationManager.requestSerializer setValue:UBER_SERVER_TOKEN forHTTPHeaderField:key_Authorization];
//    [operationManager GET:UBER_ENDPOINT_ESTIMATES_PRICE parameters:params success:success failure:failure];
//}

- (void)getUberPriceWithStartLatitude:(CLLocationDegrees)startLatitude
                       startLongitude:(CLLocationDegrees)startLongitude
                          endLatitude:(CLLocationDegrees)endLatitude
                         endLongitude:(CLLocationDegrees)endLongitude
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSDictionary* params = @{key_start_latitude: @(startLatitude),
                             key_start_longitude: @(startLongitude),
                             key_end_latitude: @(endLatitude),
                             key_end_longitude: @(endLongitude)
                             };
    
    AFHTTPRequestOperationManager* operationManager = [self operationManager];
    [operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Token %@", UBER_SERVER_TOKEN] forHTTPHeaderField:key_Authorization];
    [operationManager GET:UBER_ENDPOINT_ESTIMATES_PRICE parameters:params success:success failure:failure];
}

- (void)getUberPricesWithStartLatitude:(CLLocationDegrees)startLatitude
                       startLongitude:(CLLocationDegrees)startLongitude
                          endLatitude:(CLLocationDegrees)endLatitude
                         endLongitude:(CLLocationDegrees)endLongitude
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSDictionary* params = @{key_start_latitude: @(startLatitude),
                             key_start_longitude: @(startLongitude),
                             key_end_latitude: @(endLatitude),
                             key_end_longitude: @(endLongitude)
                             };
    
    AFHTTPRequestOperationManager* operationManager = [self operationManager];
    [operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Token %@", UBER_SERVER_TOKEN] forHTTPHeaderField:key_Authorization];
    [operationManager GET:UBER_ENDPOINT_ESTIMATES_PRICE parameters:params success:success failure:failure];
}

- (void)getLyftPriceWithStartLatitude:(CLLocationDegrees)startLatitude
                       startLongitude:(CLLocationDegrees)startLongitude
                          endLatitude:(CLLocationDegrees)endLatitude
                         endLongitude:(CLLocationDegrees)endLongitude
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self getLyftBearerTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Authorization (Lyft) : %@", responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            self.lyftAccessToken = responseObject[key_access_token];
            
            NSDictionary* params = @{key_start_lat: @(startLatitude),
                                     key_start_lng: @(startLongitude),
                                     key_end_lat: @(endLatitude),
                                     key_end_lng: @(endLongitude)
                                     };
            
            AFHTTPRequestOperationManager* operationManager = [self operationManager];
            [operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", self.lyftAccessToken]
                                      forHTTPHeaderField:key_Authorization];
            [operationManager GET:LYFT_ENDPOINT_COST parameters:params success:success failure:failure];
        }
        else {
            success(operation, nil);
        }
    } failure:failure];
}

- (void)getLyftBearerTokenWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString* lyftSecret = [NSString stringWithFormat:@"%@:%@", LYFT_CLIENT_ID, LYFT_CLIENT_SECRET];
    lyftSecret = [self.class base64EncodedStringFromString:lyftSecret];
    NSDictionary* params = @{
                             key_grant_type: key_client_credentials,
                             key_scope: key_public
                             };
    
    AFHTTPRequestOperationManager* operationManager = [self operationManager];
    [operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Basic %@", lyftSecret] forHTTPHeaderField:key_Authorization];
    [operationManager POST:LYFT_ENDPOINT_BEARER_TOKEN parameters:params success:success failure:failure];
}


@end
