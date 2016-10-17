//
//  SMUser.m
//  ProjectAlpha
//
//  Created by Gerardo Martinez on 10/16/16.
//  Copyright © 2016 Soemex. All rights reserved.
//

#import "SMUser.h"
#import "SMError.h"
#import "SMCloudAPI.h"

static NSString *kUsersURL = @"/Users";

static NSString *kParameterName = @"Name";
static NSString *kParameterLastName = @"LastName";
static NSString *kParameterUserName = @"UserName";
static NSString *kParameterEmail = @"Email";
static NSString *kParameterPassword = @"PasswordHash";
static NSString *kParameterGender = @"Gender";
static NSString *kParameterWhenCreated = @"WhenCreated";
static NSString *kParameterWhenLastModified = @"WhenLastModified";


@interface SMUser ()

@property (strong, nonatomic) NSString *password;

@property (nonatomic, readwrite) BOOL isLoggedIn;
@property (strong, nonatomic, readwrite) NSDate *whenCreated;
@property (strong, nonatomic, readwrite) NSDate *whenLastModified;

@end

@implementation SMUser

//--------------------------------------------------------------------------------------------------
#pragma mark - SMPersistentObject

// see SMPersistentObject
- (BOOL)validate:(NSError * _Nullable __autoreleasing *)error
{
	if ((!self.name) || (self.name.length == 0)) {
		if (error) {
			*error = [SMError errorWithCode:SMErrorValidationFailed details:@"Name property can't be empty."];
		}
		return NO;
	}
	
	if ((!self.email) || (self.email.length == 0)) {
		if (error) {
			*error = [SMError errorWithCode:SMErrorValidationFailed details:@"Email property can't be empty."];
		}
		return NO;
	}
	
	if (![self.gender isEqualToString:@"Male"] || ![self.gender isEqualToString:@"Female"]) {
		if (error) {
			*error = [SMError errorWithCode:SMErrorValidationFailed details:@"Invalid gender, only 'Male' or 'Female' is allowed."];
		}
		return NO;
	}
	
	return YES;
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Properties

- (void)setPassword:(NSString *)password
{
	_password = password;
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Initializing users

- (instancetype)init
{
	return [super init];
}

- (instancetype)initWithName:(NSString *)name
					lastName:(NSString *)lastName
					userName:(NSString *)userName
					   email:(NSString *)email
					password:(NSString *)password
					  gender:(NSString *)gender
{
	self = [super init];
	if (self) {
		_name = name;
		_lastName = lastName;
		_userName = userName;
		_email = email;
		_password = password;
		_gender = gender;
		
		// Set it to the creation dates
		_whenCreated = [NSDate date];
		_whenLastModified = _whenCreated;
	}
	return self;
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Creating users

- (void)createUserWithSuccess:(void (^)(SMUser *user))success
					  failure:(void (^)(NSError *error))failure
{
	NSError *error;
	if ([self validate:&error]) {
		// $TODO: Should I persist it before or after success. [GM 2016-10-16]
		// Persist the object locally
		[self persist:&error];
		
		// Create the user in the cloud
		[SMCloudAPI sendRequestWithMethod:SMHTTPMethodPost urlString:kUsersURL
								   params:[self parameterDictionary]
								  success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
									  // $TODO: Is this a user object? [GM 2016-10-16]
									  self.isLoggedIn = YES;
									  success(responseObject);
								  }
								  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
									  self.isLoggedIn = NO;
									  failure(error);
								  }];
	}
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Logging In and Out

+ (void)logInWithUsername:(NSString *)userName
				 password:(NSString *)password
				  success:(void (^)(SMUser *user))success
				 failure:(void (^)(NSError *error))failure
{
	// tbd
	return;
}

- (void)logOut
{
	[self beginUpdate:NULL];
	self.isLoggedIn = NO;
	[self commitUpdate:NULL];
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Private Methods

- (NSDictionary *)parameterDictionary
{
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	
	if (self.name) {
		dictionary[kParameterName] = self.name;
	}
	if (self.lastName) {
		dictionary[kParameterLastName] = self.lastName;
	}
	if (self.userName) {
		dictionary[kParameterUserName] = self.userName;
	}
	if (self.email) {
		dictionary[kParameterEmail] = self.email;
	}
	if (self.password) {
		dictionary[kParameterPassword] = self.password;
	}
	if (self.gender) {
		dictionary[kParameterGender] = self.gender;
	}
	
	return [dictionary copy];
}

@end
