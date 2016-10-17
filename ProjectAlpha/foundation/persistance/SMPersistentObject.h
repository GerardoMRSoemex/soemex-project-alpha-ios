//
//  SMPersistentObject.h
//  ProjectAlpha
//
//  Created by Gerardo Martinez on 10/16/16.
//  Copyright © 2016 Soemex. All rights reserved.
//

#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

//==================================================================================================
// BLPersistentObject
//==================================================================================================

@interface SMPersistentObject : RLMObject

/// @name Properties

@property (nonatomic) NSString *uuid;
@property (nonatomic, readonly) BOOL isPersisted;

/// @name Creating Persistent Objects

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithValue:(id)value NS_UNAVAILABLE;

/// @name Managing Object Persistence

- (BOOL)persist:(NSError **)error;
- (BOOL)beginUpdate:(NSError **)error;
- (BOOL)commitUpdate:(NSError **)error;
- (BOOL)cancelUpdate:(NSError **)error;

/// @name Validating Objects

- (BOOL)validate:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
