//
//  SMError.h
//  ProjectAlpha
//
//  Created by Gerardo Martinez on 10/16/16.
//  Copyright © 2016 Soemex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Blast Foundation Error Domain
extern NSString *const BLFoundationErrorDomain;

// Blast Error Details Separator
extern NSString *const SMErrorDetailsSeparator;

/// Blast Foundation error codes.
typedef NS_ENUM(NSUInteger, SMErrorCode) {
	
	/// @name 100 - Bluetooth Error Codes
	
	/// Bluetooth is not.
	SMErrorBluetoothNotOn = 100,
	/// The Bluetooth session is not in the required state. For example, the foundation was expecting
	/// the session to be connected to a peripheral, but it is disconnected.
	SMErrorBluetoothSessionNotInRequiredState = 101,
	/// Tried to start scanning for peripherals, but already scanning.
	SMErrorBluetoothAlreadyScanning = 102,
	/// Expected Bluetooth to be connected to a peripheral, but it is not.
	SMErrorNotConnectedToBluetoothPeripheral = 103,
	/// Tried to find a characteristic for a peripheral, but the peripheral does not support the characteristic.
	SMErrorCharacteristicNotFoundForBluetoothPeripheral = 104,
	
	/// @name 200 - Synching Error Codes
	
	/// Error persisting an object
	SMErrorPersistingFailed = 200,
	/// Error editing an object
	SMErrorEditingFailed = 201,
	/// Validation error
	SMErrorValidationFailed = 202,
};

/**
 * SMError is an error helper class that provides NSError's with the Soemex domain.
 */
@interface SMError : NSObject

/// @name Creating Errors

+ (NSError *)errorWithCode:(SMErrorCode)errorCode;
+ (NSError *)errorWithCode:(SMErrorCode)errorCode details:(NSString *)details;

@end

NS_ASSUME_NONNULL_END
