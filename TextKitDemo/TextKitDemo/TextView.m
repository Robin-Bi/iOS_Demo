//
//  TextView.m
//  TextKitDemo
//
//  Created by Rui on 2018/9/29.
//  Copyright © 2018年 毕瑞. All rights reserved.
//

#import "TextView.h"
#import <CoreText/CTFramesetter.h>

@implementation TextView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, self.bounds);
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello World"];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attString.length), path, NULL);
    
    CTFrameDraw(frame, context);
    
    CFRelease(frame);
    CGPathRelease(path);
    CGContextRelease(context);
}

@end
