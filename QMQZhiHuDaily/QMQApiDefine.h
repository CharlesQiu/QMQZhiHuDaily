//
//  QMQApiDefine.h
//  QMQZhiHuDaily
//
//  Created by Charles on 1/6/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#ifndef QMQApiDefine_h
#define QMQApiDefine_h

/// 热门新闻
#define API_HOT_NEWS    @"http://news-at.zhihu.com/api/3/news/hot"
/// 最新新闻
#define API_LATEST_NEWS @"http://news-at.zhihu.com/api/4/news/latest"
/// 主题新闻
#define API_THEMES      @"http://news-at.zhihu.com/api/4/themes"
/// 专题新闻
#define API_SECTIONS    @"http://news-at.zhihu.com/api/3/sections"
/// 历史新闻
#define API_BEFORE_NEWS(date) [NSString stringWithFormat:@"http://news.at.zhihu.com/api/4/news/before/%@", date]

#endif /* QMQApiDefine_h */
