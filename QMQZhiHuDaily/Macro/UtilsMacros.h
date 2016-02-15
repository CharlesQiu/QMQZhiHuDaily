//
//  UtilsMacros.h
//  QMQZhiHuDaily
//
//  Created by Charles on 1/26/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

/**
 *  @brief Colorful log
 */
#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelOff;
#endif
#define COLOR_DDLogVerbose hexRGBA(58, 129, 195, 255)
#define COLOR_DDLogInfo    hexRGBA(71, 164, 71, 255)
#define COLOR_DDLogDebug   hexRGBA(252, 210, 10, 255)

/**
 *  @brief Debug Log and Log
 */
#ifdef DEBUG
#define DEBUG_LOG(msg) NSLog(@"%s:\n%@", __FUNCTION__, (msg))
#else
#define DEBUG_LOG(msg)
#define NSLog(...)
#endif

/**
 *  @brief A better version of NSLog
 */
#define DebugLog(msg) DDLogDebug(@"\n--------------------\nCLASS:%s <> LINE:%d\n--------------------\nMETHOD:%s\n--------------------\n%@\n--------------------", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__, msg);
#define ErrorLog(msg) DDLogError(@"\n--------------------\nCLASS:%s <> LINE:%d\n--------------------\nMETHOD:%s\n--------------------\n%@\n--------------------", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__, msg);
#define InfoLog(msg) DDLogInfo(@"\n--------------------\nCLASS:%s <> LINE:%d\n--------------------\nMETHOD:%s\n--------------------\n%@\n--------------------", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__, msg);
#define VerboseLog(msg) DDLogVerbose(@"\n--------------------\nCLASS:%s <> LINE:%d\n--------------------\nMETHOD:%s\n--------------------\n%@\n--------------------", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__, msg);
#define WarnLog(msg) DDLogWarn(@"\n--------------------\nCLASS:%s <> LINE:%d\n--------------------\nMETHOD:%s\n--------------------\n%@\n--------------------", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__, msg);
#define LogCGRect(description, rect) DDLogWarn(@"\n++++++%@++++++\n{ %.1f(x) , %.1f(y) , %.1f(w) , %.1f(h) }\n------%@------\n", description, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height, description);
#define LogCGSize(description, size) DDLogInfo(@"\n++++++%@++++++\n{ %.1f(w) , %.1f(h) }\n------%@------\n", description, size.width, size.height, description);
#define LogCGPoint(description, point) DDLogVerbose(@"\n++++++%@++++++\n{ %.1f(x) , %.1f(y) }\n------%@------\n", description, point.x, point.y, description);


#endif /* UtilsMacros_h */
