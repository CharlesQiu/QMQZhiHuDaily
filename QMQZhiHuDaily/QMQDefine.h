//
//  QMQDefine.h
//  QMQZhiHuDaily
//
//  Created by Charles on 12/29/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//
#ifndef QMQDefine_h
#define QMQDefine_h

/**
 *  @brief Icon Font
 */
#define ICON_FONT_ICOMOON @"icomoon"

/**
 *  @brief Screen Size
 */
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define STATUSBAR_HEIGHT     20
#define NAVIGATIONBAR_HEIGHT 44
#define TABBAR_HEIGHT        49

/**
 *  @brief Color
 */
#define HexRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f]

/**
 *  @brief Colorful log
 */
#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_OFF;
#endif
#define COLOR_DDLogVerbose HexRGBA(58, 129, 195, 255)
#define COLOR_DDLogInfo    HexRGBA(71, 164, 71,        255)
#define COLOR_DDLogDebug   HexRGBA(252, 210, 10, 255)

/**
 *  @brief Debug Log and Log
 */
#ifdef DEBUG
#define DEBUG_LOG(msg) NSLog(@"%s:\n%@",__FUNCTION__,(msg))
#else
#define DEBUG_LOG(msg)
#define NSLog(...)
#endif

/**
 *  @brief A better version of NSLog
 */
#define DebugLog(msg) DDLogDebug(@"\n--------------------\nCLASS:%s <> LINE:%d\n--------------------\nMETHOD:%s\n--------------------\n%@\n--------------------",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__, msg);
#define ErrorLog(msg) DDLogError(@"\n--------------------\nCLASS:%s <> LINE:%d\n--------------------\nMETHOD:%s\n--------------------\n%@\n--------------------",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__, msg);
#define InfoLog(msg) DDLogInfo(@"\n--------------------\nCLASS:%s <> LINE:%d\n--------------------\nMETHOD:%s\n--------------------\n%@\n--------------------",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__, msg);
#define VerboseLog(msg) DDLogVerbose(@"\n--------------------\nCLASS:%s <> LINE:%d\n--------------------\nMETHOD:%s\n--------------------\n%@\n--------------------",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__, msg);
#define WarnLog(msg) DDLogWarn(@"\n--------------------\nCLASS:%s <> LINE:%d\n--------------------\nMETHOD:%s\n--------------------\n%@\n--------------------",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__, msg);

#endif /* QMQDefine_h */
