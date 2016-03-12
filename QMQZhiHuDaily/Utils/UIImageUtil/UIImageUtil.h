//
//  QMQUIImageUtils.h
//  QMQZhiHuDaily
//
//  Created by Charles on 12/29/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

@interface UIImageUtil : NSObject

/**
 *  把icomoon字体文件中的code转成图片。
 *  @param code     图片code
 *  @param color    图片颜色
 *  @param fontSize 图片大小
 *  @return UIImage
 */
+ (UIImage *)imageWithIconFontCode:(NSString *)code color:(UIColor *)color fontSize:(CGFloat)fontSize;

/**
 *  生成纯颜色的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end