//
//  SMUser.h
//  ProjectAlpha
//
//  Created by Gerardo Martinez on 10/16/16.
//  Copyright © 2016 Soemex. All rights reserved.
//

#import "SMPersistentObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMUser : SMPersistentObject

/// @name Properties

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *gender;
@property (nonatomic, readonly) BOOL isLoggedIn;
@property (strong, nonatomic, readonly) NSDate *whenCreated;
@property (strong, nonatomic, readonly) NSDate *whenLastModified;

- (void)setPassword:(NSString *)password;

/// @name Initializing users

- (instancetype)init;
- (instancetype)initWithName:(NSString *)name
					lastName:(nullable NSString *)lastName
					userName:(NSString *)userName
					   email:(NSString *)email
					password:(NSString *)password
					  gender:(nullable NSString *)gender;

/// @name Creating user entries in the server

- (void)createUserWithSuccess:(void (^)(SMUser *user))success
					  failure:(void (^)(NSError *error))failure;

/// @name Logging In and Out

+ (void)logInWithUsername:(NSString *)userName
				 password:(NSString *)password
				  success:(void (^)(SMUser *user))success
				  failure:(void (^)(NSError *error))failure;
- (void)logOut;

@end

NS_ASSUME_NONNULL_END
