//
//  SMPersistentObject.m
//  ProjectAlpha
//
//  Created by Gerardo Martinez on 10/16/16.
//  Copyright © 2016 Soemex. All rights reserved.
//

#import "SMPersistentObject.h"
#import "SMError.h"

@interface SMPersistentObject ()

@property (readonly, nonatomic) RLMRealm *realm;

@end

@implementation SMPersistentObject

@synthesize realm = _realm;

//----------------------------------------------------------------------
#pragma mark - RLMObject

// This is how we tell Realm what the primary key is.
+ (NSString *)primaryKey
{
	return @"uuid";
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Properties

- (RLMRealm *)realm
{
	if (!_realm) {
		_realm = [RLMRealm defaultRealm];
	}
	return _realm;
}

@dynamic isPersisted;
- (BOOL)isPersisted
{
	NSString *className = NSStringFromClass([self class]);
	
	return ![className containsString:@"RLMUnmanaged"];
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Creating Persistent Objects

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.uuid = [[NSUUID UUID] UUIDString];
	};
	return [super init];
}

- (instancetype)initWithValue:(id)value
{
	return [self init];
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Managing Object Persistence

- (BOOL)persist:(NSError **)error
{
	@try {
		[self.realm beginWriteTransaction];
		[self.realm addObject:self];
		[self.realm commitWriteTransaction];
	}
	@catch (NSException *exception) {
		if (error) {
			*error = [SMError errorWithCode:SMErrorPersistingFailed details:exception.description];
		}
		return NO;
	}
	return YES;
}

- (BOOL)transactionWithBlock:(nonnull void (^)(void))block
					   error:(NSError **)error
{
	// tbd
	return (0);
}

- (BOOL)beginUpdate:(NSError **)error
{
	if (self.isPersisted && !self.realm.inWriteTransaction) {
		@try {
			[self.realm beginWriteTransaction];
		}
		@catch (NSException *exception) {
			if (error) {
				*error = [SMError errorWithCode:SMErrorEditingFailed details:exception.description];
			}
			return NO;
		}
	}
}

- (BOOL)commitUpdate:(NSError **)error
{
	if (self.isPersisted && self.realm.inWriteTransaction) {
		@try {
			[self.realm commitWriteTransaction];
		}
		@catch (NSException *exception) {
			if (error) {
				*error = [SMError errorWithCode:SMErrorEditingFailed details:exception.description];
			}
			return NO;
		}
	}
}

- (BOOL)cancelUpdate:(NSError **)error
{
	if (self.isPersisted) {
		@try {
			[self.realm cancelWriteTransaction];
		}
		@catch (NSException *exception) {
			if (error) {
				*error = [SMError errorWithCode:SMErrorEditingFailed details:exception.description];
			}
			return NO;
		}
	}
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Validating Objects

- (BOOL)validate:(NSError **)error
{
	return NO;
}

@end
