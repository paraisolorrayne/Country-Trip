//
//  RoundedButton.m
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 27/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "RoundedButton.h"

@interface RoundedButton ()
@property (nonatomic) CGFloat borderWidth;
@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) NSString *subtitleText;
@end

@implementation RoundedButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    
    [self setNeedsDisplay];
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat borderWidth = self.borderWidth ? self.borderWidth : 1;
    CGRect borderRect = CGRectMake(rect.origin.x + borderWidth, rect.origin.y + borderWidth, rect.size.width - 2*borderWidth, rect.size.height - 2*borderWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:borderRect cornerRadius:6.0f];
    path.lineWidth = borderWidth;
    
    self.bgColor = self.bgColor ?: [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.0f alpha:0.2f];
    CGContextSetFillColorWithColor(context, (self.highlighted ? [self highlitedColorFromColor:self.bgColor] : self.bgColor).CGColor);
    [path fill];
    
    self.borderColor = self.borderColor ?: UIColor.whiteColor;
    CGContextSetStrokeColorWithColor(context, (self.highlighted ? [self highlitedColorFromColor:self.borderColor] : self.borderColor).CGColor);
    [path stroke];
    
    self.titleText = self.titleText.length > 0 ? self.titleText : @"";
    NSMutableDictionary *titleAttribs = [@{} mutableCopy];
    [titleAttribs setObject:self.titleLabel.font forKey:NSFontAttributeName];
    [titleAttribs setObject:@0 forKey:NSStrokeWidthAttributeName];
    [titleAttribs setObject:UIColor.whiteColor forKey:NSForegroundColorAttributeName];
    CGSize titleSize = [self.titleText sizeWithAttributes:titleAttribs];
    if (self.titleText.length > 0) {
        [self.titleText drawAtPoint:CGPointMake((self.frame.size.width / 2) - (titleSize.width / 2), (self.frame.size.height / 2) - 24) withAttributes:titleAttribs];
    }
    
    self.subtitleText = self.subtitleText.length > 0 ? self.subtitleText : @"";
    if (self.subtitleText.length > 0) {
        NSMutableDictionary *subtitleAttribs = [@{} mutableCopy];
        //        UIFont *font = [UIFont fontWithName:self.titleLabel.font.fontName size:14];
        UIFont *font = [UIFont italicSystemFontOfSize:12];
        [subtitleAttribs setObject:font forKey:NSFontAttributeName];
        [subtitleAttribs setObject:@0 forKey:NSStrokeWidthAttributeName];
        [subtitleAttribs setObject:UIColor.whiteColor forKey:NSForegroundColorAttributeName];
        
        CGSize textSize = [self.subtitleText sizeWithAttributes:subtitleAttribs];
        [self.subtitleText drawAtPoint:CGPointMake((self.frame.size.width / 2) - (textSize.width / 2), (self.frame.size.height / 2)) withAttributes:subtitleAttribs];
    }
}

- (UIColor *)highlitedColorFromColor:(UIColor *)color {
    size_t components = CGColorGetNumberOfComponents(color.CGColor);
    if (components > 0) {
        CGFloat alpha = CGColorGetComponents(color.CGColor)[components - 1];
        if (alpha <= 0) {
            return color;
        } else {
            return [color colorWithAlphaComponent:0.8];
        }
    } else {
        return color;
    }
}

@end
