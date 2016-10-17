//
//  SMCloudAPI.m
//  ProjectAlpha
//
//  Created by Gerardo Martinez on 10/16/16.
//  Copyright © 2016 Soemex. All rights reserved.
//

#import "SMCloudAPI.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPSessionManager.h>

static NSString *kBaseURL = @"https://api.airtable.com/v0/appHMuLuacac5FvRV";
static NSString *kAPIKey = @"keyqIbMBZ5WARtpbN";
static NSString *kAuthorization = @"Authorization";

@implementation SMCloudAPI

+ (void)sendRequestWithMethod:(SMHTTPMethod)method
					urlString:(NSString *)urlString
					   params:(NSDictionary *)parameters
					  success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject))success
					  failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
	// $TODO: If this goes to a framework, base url needs to be a static setter method. [GM 2016-10-16]
	AFHTTPSessionManager *manager = [self getRequestHTTPManagerWithURL:kBaseURL accessToken:kAPIKey];
	
	switch (method) {
		case SMHTTPMethodPost:
			[manager POST:urlString parameters:parameters progress:nil success:success failure:failure];
			break;
		case SMHTTPMethodPut:
			[manager PUT:urlString parameters:parameters success:success failure:failure];
			break;
		case SMHTTPMethodGet:
			[manager GET:urlString parameters:parameters progress:nil success:success failure:failure];
			break;
//		case SMHTTPMethodDelete:
//			manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
//			[manager DELETE:urlString parameters:parameters success:success failure:failure];
//			break;
		default:
			break;
	}
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Private Helpers

+ (AFHTTPSessionManager *)getRequestHTTPManagerWithURL:(NSString *)baseURL accessToken:(NSString *)accessToken
{
	AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
	manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	[manager.requestSerializer setValue:[self authorizationStringWithAccessToken:accessToken] forHTTPHeaderField:kAuthorization];
	return manager;
}

+ (NSString *)authorizationStringWithAccessToken:(NSString *)accessToken
{
	return [NSString stringWithFormat:@"Bearer %@", accessToken];
}

@end
