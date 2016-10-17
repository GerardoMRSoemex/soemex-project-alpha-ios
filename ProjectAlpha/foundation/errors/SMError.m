//
//  SMError.m
//  ProjectAlpha
//
//  Created by Gerardo Martinez on 10/16/16.
//  Copyright © 2016 Soemex. All rights reserved.
//

#import "SMError.h"

// Error Domain
NSString *const BLFoundationErrorDomain = @"BLFoundationErrorDomain";

// Blast Error Details Separator
NSString *const BLErrorDetailsSeparator = @" - ";

@implementation SMError

//--------------------------------------------------------------------------------------------------
#pragma mark - Creating Errors

/**
 * Creates a Soemex error object with the given code.
 *
 * This method automatically logs an error message to the debug log.
 *
 * @param errorCode The error code.
 *
 * @returns An error.
 */
+ (NSError *)errorWithCode:(SMErrorCode)errorCode
{
	return [self errorWithCode:errorCode details:@""];
}

/**
 * Same as errorWithCode: but takes an additional details string which is appended to the
 * base error description.
 *
 * This method automatically logs an error message to the debug log.
 *
 * @param errorCode The error code.
 * @param details An additional error details string.
 *
 * @returns An error.
 */
+ (NSError *)errorWithCode:(SMErrorCode)errorCode details:(NSString *)details
{
	NSString *description = [self stringWithDescription:[self descriptionForErrorCode:errorCode] details:details];
	NSLog(@"error %@: %@", @(errorCode), description);
	NSDictionary<NSString *, NSString *> *userInfo = @{NSLocalizedDescriptionKey : description};
	
	return [NSError errorWithDomain:BLFoundationErrorDomain code:errorCode userInfo:userInfo];
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Private Methods

/**
 * Builds a string with the description, and, if not nil, the details with a known separation
 * character in between.
 *
 * @param description The error description
 * @param details The error details (can be nil)
 *
 * @returns A description + details string.
 */
+ (NSString *)stringWithDescription:(NSString *)description details:(NSString *)details
{
	NSMutableCharacterSet *set = [NSMutableCharacterSet whitespaceCharacterSet];
	[set formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];
	[set removeCharactersInString:@"()"];
	description = [description stringByTrimmingCharactersInSet:set];
	
	if (details.length > 0) {
		description = [description stringByAppendingFormat:@"%@%@", BLErrorDetailsSeparator, details];
	}
	
	return [description copy];
}

/**
 * The class method provides a human readable string for a BLErrorCode.
 *
 * @param errorCode The error code that is used to provide a description.
 *
 * @returns An NSString of the human readable error message.
 */
+ (NSString *)descriptionForErrorCode:(SMErrorCode)errorCode
{
	NSString *description = @"(no description)";
	switch (errorCode) {
			
			// bluetooth
			
		case SMErrorBluetoothNotOn:
			description = @"Bluetooth is not powered on.";
			break;
		case SMErrorBluetoothSessionNotInRequiredState:
			description = @"Bluetooth session is not in required state.";
			break;
		case SMErrorBluetoothAlreadyScanning:
			description = @"Bluetooth session is already scanning.";
			break;
		case SMErrorNotConnectedToBluetoothPeripheral:
			description = @"Bluetooth session is not connected to a peripheral.";
			break;
		case SMErrorCharacteristicNotFoundForBluetoothPeripheral:
			description = @"Characteristic not found for Bluetooth peripheral.";
			break;
		
	}
	
	return description;
}

@end
