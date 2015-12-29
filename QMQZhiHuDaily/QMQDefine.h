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
 *  @brief Debug Log and Log
 */
#ifdef DEBUG
#define DEBUG_LOG(msg) NSLog(@"%s:\n%@",__FUNCTION__,(msg))
#else
#define DEBUG_LOG(msg)
#define NSLog(...)
#endif

#endif /* QMQDefine_h */
