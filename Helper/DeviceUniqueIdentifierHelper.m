//
//  DeviceUniqueIdentifierHelper.m
//  Sale_app
//
//  Created by eddy_Mac on 2018/8/24.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "DeviceUniqueIdentifierHelper.h"

static NSString * const KEY_IN_KEYCHAIN = @"com.jugu.keychain";
static NSString * const KEY_DEVICEID = @"com.jugu.deviceid";

@implementation DeviceUniqueIdentifierHelper

/*
 从钥匙串取设备id
 */
+ (id)readDeviceUniqueIdentifier
{
    NSString *deviceId = nil;
    
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[self load:KEY_IN_KEYCHAIN];
    
    deviceId = [usernamepasswordKVPair objectForKey:KEY_DEVICEID];
    
    if (!deviceId)
    {
        deviceId = [[UIDevice currentDevice].identifierForVendor UUIDString];
        
        [self saveDeviceId:deviceId];
    }
    
    return deviceId;
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            service, (__bridge id)kSecAttrService,
            service, (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,nil];
}

/*
 保存设备id到钥匙串
 */
+ (void)saveDeviceId:(NSString *)deviceId
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:deviceId forKey:KEY_DEVICEID];
    [self save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+ (void)deleteDeviceId
{
    [self delete:KEY_IN_KEYCHAIN];
}

+ (void)save:(NSString *)service data:(id)data
{
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    
    
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
    
    if (keychainQuery) {
        CFRelease((__bridge CFTypeRef)(keychainQuery));
    }
    if (keychainQuery) {
        CFRelease((__bridge CFTypeRef)(keychainQuery));
    }
}

+ (id)load:(NSString *)service
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    return ret;
}

+ (void)delete:(NSString *)service
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    if (keychainQuery) {
        CFRelease((__bridge CFTypeRef)(keychainQuery));
    }
}

@end
