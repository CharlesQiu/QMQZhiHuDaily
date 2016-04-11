//
//  ApiMacro.h
//  QMQZhiHuDaily
//
//  Created by Charles on 1/26/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#ifndef ApiMacro_h
#define ApiMacro_h

#ifdef DEBUG
//Debug状态下的测试API
#define API_BASE_URL_STRING    @"http://news-at.zhihu.com/api/"
#define API_HISTORY_URL_STRING @"http://news.at.zhihu.com/api/"
#else
//Release状态下的线上API
#define API_BASE_URL_STRING    @"http://news-at.zhihu.com/api/"
#define API_HISTORY_URL_STRING @"http://news.at.zhihu.com/api/"
#endif


/// 热门新闻
#define API_HOT_NEWS    [API_BASE_URL_STRING stringByAppendingFormat:@"3/news/hot"]
/// 最新新闻
#define API_LATEST_NEWS [API_BASE_URL_STRING stringByAppendingFormat:@"4/news/latest"]
/// 主题新闻
#define API_THEMES      [API_BASE_URL_STRING stringByAppendingFormat:@"4/themes"]
/// 主题详细
#define API_THEME_DETAIL(id) [API_BASE_URL_STRING stringByAppendingFormat:@"4/theme/%@", id]
/// 专题新闻
#define API_SECTIONS    [API_BASE_URL_STRING stringByAppendingFormat:@"3/sections"]
/// 专题详细
#define API_SECTION_DETAIL(id) [API_BASE_URL_STRING stringByAppendingFormat:@"3/section/%@", id]
/// 历史新闻
#define API_BEFORE_NEWS(date) [API_HISTORY_URL_STRING stringByAppendingFormat:@"4/news/before/%@", date]

#define API_GET_NEWS_DETAIL(newsId) [API_BASE_URL_STRING stringByAppendingFormat:@"4/news/%lu", newsId]

#endif /* ApiMacro_h */
