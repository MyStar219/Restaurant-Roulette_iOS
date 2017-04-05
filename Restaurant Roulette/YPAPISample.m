//
//  YPAPISample.m
//  YelpAPI

#import "YPAPISample.h"

/**
 Default paths and search terms used in this example
 */
static NSString * const kAPIHost           = @"api.yelp.com";
static NSString * const kSearchPath        = @"/v2/search/";
static NSString * const kBusinessPath      = @"/v2/business/";

@implementation YPAPISample

#pragma mark - Public

- (void)queryTopBusinessInfoForTerm:(NSString *)term location:(NSString *)location completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {

  NSLog(@"Querying the Search API with term \'%@\' and location \'%@'", term, location);

  //Make a first request to get the search results with the passed term and location
  NSURLRequest *searchRequest = [self _searchRequestWithTerm:term location:location];
  NSURLSession *session = [NSURLSession sharedSession];
  [[session dataTaskWithRequest:searchRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

    if (!error && httpResponse.statusCode == 200) {

      NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
      NSArray *businessArray = searchResponseJSON[@"businesses"];

      if ([businessArray count] > 0) {
        NSDictionary *firstBusiness = [businessArray firstObject];
        NSString *firstBusinessID = firstBusiness[@"id"];
        NSLog(@"%lu businesses found, querying business info for the top result: %@", (unsigned long)[businessArray count], firstBusinessID);

        [self queryBusinessInfoForBusinessId:firstBusinessID completionHandler:completionHandler];
      } else {
        completionHandler(nil, error); // No business was found
      }
    } else {
      completionHandler(nil, error); // An error happened or the HTTP response is not a 200 OK
    }
  }] resume];
}

- (void)queryNearbyRestaurantsInfoForTerm:(NSString *)term ll:(NSString *)ll limit:(NSString *)limit sort:(NSString *)sort radius_filter:(NSString *)radius_filter completionHandler:(void (^)(NSArray *arrJSON, NSError *error))completionHandler{
    
    NSLog(@"Querying the Search API with cll %@ and limit \'%@\' and radius \'%@\' and sort \'%@\'", ll, limit, radius_filter, sort);
    
    NSURLRequest *searchRequest = [self _searchRequestWithTerm:term ll:ll limit:limit sort:sort radius_filter:radius_filter];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:searchRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (!error && httpResponse.statusCode == 200) {
            
            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSArray *businessArray = searchResponseJSON[@"businesses"];
            
            NSMutableArray *arrJsonInfo = [[self filterArray:businessArray] mutableCopy];
            NSLog(@"total : %@", @(arrJsonInfo.count));
            
            if ([arrJsonInfo count] > 0) {
//                int pickedIndex = rand() % arrJsonInfo.count;
//                
//                NSLog(@"-----------------%d-------------------", pickedIndex);
//                
//                NSDictionary *jsonRestInfo = [arrJsonInfo objectAtIndex:pickedIndex];
//                
//                NSString *businessID = jsonRestInfo[@"id"];
//                [self queryBusinessArrayInfoForBusinessId:businessID completionHandler:completionHandler];
                completionHandler(arrJsonInfo, error);
            } else {
                completionHandler(nil, error); // No business was found
            }
        } else {
            completionHandler(nil, error); // An error happened or the HTTP response is not a 200 OK
        }
    }] resume];
}

- (NSMutableArray *)filterArray:(NSArray *)nearByRestaurantsJSON{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    NSArray *arrToDistance = @[@(3), @(5), @(10), @(15), @(20)];
    
    for (NSDictionary *jsonDict in nearByRestaurantsJSON) {
        if (![jsonDict[@"is_closed"] isEqualToNumber:[NSNumber numberWithInt:0]]){
            continue;
        }
        
        float distanceInMeter = [jsonDict[@"distance"] floatValue];
        NSInteger nIndex = [[defaults objectForKey:sDistanceLevelStorageKey]integerValue];
        
        float distanceTo = [[arrToDistance objectAtIndex:nIndex] floatValue] * convertMileToKilometre * 1000.0;
        
        if (distanceInMeter <= distanceTo){
            [arr addObject:jsonDict];
        }
    }
    return arr;
}

- (void)queryNearbyRestaurantsInfoForTerm:(NSString *)term location:(NSString *)location cll:(NSString *)cll limit:(NSString *)limit sort:(NSString *)sort radius_filter:(NSString *)radius_filter completionHandler:(void (^)(NSDictionary *jsonResponse, NSError *error))completionHandler{
    //Make a first request to get the search results with the passed term and location
    NSURLRequest *searchRequest = [self _searchRequestWithTerm:term location:location cll:cll limit:(NSString *)limit sort:(NSString *)sort radius_filter:(NSString *)radius_filter];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:searchRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (!error && httpResponse.statusCode == 200) {
            
            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSArray *businessArray = searchResponseJSON[@"businesses"];
            
            if ([businessArray count] > 0) {
                NSDictionary *firstBusiness = [businessArray firstObject];
                NSString *firstBusinessID = firstBusiness[@"id"];
                
                NSLog(@"%lu businesses found, querying business info for the top result: %@", (unsigned long)[businessArray count], firstBusinessID);
                
                [self queryBusinessInfoForBusinessId:firstBusinessID completionHandler:completionHandler];
            } else {
                completionHandler(nil, error); // No business was found
            }
        } else {
            completionHandler(nil, error); // An error happened or the HTTP response is not a 200 OK
        }
    }] resume];
}

- (void)queryBusinessInfoForBusinessId:(NSString *)businessID completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {

  NSURLSession *session = [NSURLSession sharedSession];
  NSURLRequest *businessInfoRequest = [self _businessInfoRequestForID:businessID];
  [[session dataTaskWithRequest:businessInfoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (!error && httpResponse.statusCode == 200) {
      NSDictionary *businessResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

      completionHandler(businessResponseJSON, error);
    } else {
      completionHandler(nil, error);
    }
  }] resume];

}

- (void)queryBusinessArrayInfoForBusinessId:(NSString *)businessID completionHandler:(void (^)(NSArray *topBusinessJSON, NSError *error))completionHandler {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *businessInfoRequest = [self _businessInfoRequestForID:businessID];
    [[session dataTaskWithRequest:businessInfoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!error && httpResponse.statusCode == 200) {
            NSDictionary *businessResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
//            NSLog(@"completion: %@", businessResponseJSON);
            
            completionHandler(@[businessResponseJSON], error);
        } else {
            completionHandler(nil, error);
        }
    }] resume];
    
}


#pragma mark - API Request Builders

/**
 Builds a request to hit the search endpoint with the given parameters.
 
 @param term The term of the search, e.g: dinner
 @param location The location request, e.g: San Francisco, CA

 @return The NSURLRequest needed to perform the search
 */
- (NSURLRequest *)_searchRequestWithTerm:(NSString *)term location:(NSString *)location {
  NSDictionary *params = @{
                           @"term": term,
                           @"location": location,
                           @"limit": @"5"
                           };

  return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:params];
}

/**
 Builds a request to hit the search endpoint with the given parameters.
 
 @param term The term of the search, e.g: dinner
 @param cll The geolocation request, e.g: 37.77493,-122.419415
 
 @return The NSURLRequest needed to perform the search
 */
- (NSURLRequest *)_searchRequestWithTerm:(NSString *)term ll:(NSString *)ll limit:(NSString *)limit sort:(NSString *)sort radius_filter:(NSString *)radius_filter {
    NSString *sPriceLevelParam = [NSString stringWithFormat:@"ActiveDeal,RestaurantsPriceRange2.%d", (int)[defaults integerForKey:sPriceLevelStorageKey] + 1];
    
    NSDictionary *params = @{
                             @"term": term,
                             @"ll": ll,
//                             @"limit": limit,
                             @"sort": sort,
                             @"attrs": sPriceLevelParam,
                             @"radius_filter": radius_filter
                             };
    
    return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:params];
}

- (NSURLRequest *)_searchRequestWithTerm:(NSString *)term location:(NSString *)location cll:(NSString *)cll limit:(NSString *)limit sort:(NSString *)sort radius_filter:(NSString *)radius_filter {
    NSDictionary *params = @{
                             @"term": term,
                             @"location": location,
                             @"cll": cll,
                             @"limit": limit,
                             @"sort": sort,
                             @"radius_filter": radius_filter
                             };
    
    return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:params];
}


/**
 Builds a request to hit the business endpoint with the given business ID.
 
 @param businessID The id of the business for which we request informations

 @return The NSURLRequest needed to query the business info
 */
- (NSURLRequest *)_businessInfoRequestForID:(NSString *)businessID {

  NSString *businessPath = [NSString stringWithFormat:@"%@%@", kBusinessPath, businessID];
  return [NSURLRequest requestWithHost:kAPIHost path:businessPath];
}

@end
