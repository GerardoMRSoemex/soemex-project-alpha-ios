//
//  SMCloudAPI.h
//  ProjectAlpha
//
//  Created by Gerardo Martinez on 10/16/16.
//  Copyright © 2016 Soemex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SMHTTPMethod) {
	SMHTTPMethodGet = 0,
	SMHTTPMethodPost = 1,
	SMHTTPMethodPut = 2,
	SMHTTPMethodDelete = 3
};

/**
 SMCloudAPI is the server interface that handles the coomunication with the Soemex "Project Alpha" 
 API. The API closely follows REST semantics, uses JSON to encode objects, and relies on standard 
 HTTP codes to signal operation outcomes.
 */
@interface SMCloudAPI : NSObject

+ (void)sendRequestWithMethod:(SMHTTPMethod)method
					urlString:(NSString *)urlString
					   params:(NSDictionary *)parameters
					  success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject))success
					  failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

@end

NS_ASSUME_NONNULL_END
