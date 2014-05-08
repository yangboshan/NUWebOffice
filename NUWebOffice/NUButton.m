//
//  NUButton.m
//  NUWebOffice
//
//  Created by JY on 14-4-22.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NUButton.h"
#import "NUApp-Macro.h"

@implementation NUButton

- (id)init{
    if (self = [super init]) {
        [self addObserver:self forKeyPath:@"highlighted"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addObserver:self forKeyPath:@"highlighted"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"highlighted"]) {
        if ([[change valueForKey:@"new"] integerValue]) {
            self.backgroundColor = RGBA(1, 1, 1, 0.1);
        }else{
            self.backgroundColor = [UIColor clearColor];
        }
    }
    [self setNeedsDisplay];
}

//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    
//    if (self.highlighted == YES)
//    {
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        
//        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
//        
//        const CGFloat *topGradientColorComponents = CGColorGetComponents([UIColor whiteColor].CGColor);
//        const CGFloat *bottomGradientColorComponents = CGColorGetComponents([UIColor blackColor].CGColor);
//        
//        CGFloat colors[] =
//        {
//            topGradientColorComponents[0], topGradientColorComponents[1], topGradientColorComponents[2], topGradientColorComponents[3],
//            bottomGradientColorComponents[0], bottomGradientColorComponents[1], bottomGradientColorComponents[2], bottomGradientColorComponents[3]
//        };
//        CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors) / (sizeof(colors[0]) * 4));
//        CGColorSpaceRelease(rgb);
//        
//        CGContextDrawLinearGradient(ctx, gradient, CGPointMake(0, 0), CGPointMake(0, self.bounds.size.height), 0);
//        CGGradientRelease(gradient);
//    }
//    else
//    {
//        // Do custom drawing for normal state
//    }
//}

//-(void)setHighlighted:(BOOL)highlighted{
//    if (highlighted) {
//        self.backgroundColor = RGBA(1, 1, 1, 0.1);
//    } else {
//        self.backgroundColor = [UIColor clearColor];
//    }
//}

+(NUButton*)mainPageBtnWithImage:(NSString*)image withRect:(CGRect)rect{
    
    UIImage* btnImage = [UIImage imageNamed:image];
    NUButton* customBtn = [[NUButton alloc] initWithFrame:rect];
    
    [customBtn setFrame:rect];
    [customBtn setImage:btnImage forState:UIControlStateNormal];
    
    return customBtn;
}

+(NUButton*)mainPageDetailBtnWithImage:(NSString*)image withText:(NSString*)text
                              withRect:(CGRect)rect{
    
    NUButton* mainPageBtn = [[NUButton alloc] initWithFrame:rect];
    [mainPageBtn setFrame:rect];
    
    UIImage *_image = [UIImage imageNamed:image];
    UIImageView* btnImage = [[UIImageView alloc] initWithImage:
                             _image];
    
    [btnImage setFrame:CGRectMake(RectWidth(rect)/2.0 - _image.size.width/2.0,
                                  RectHeight(rect)/2.0 -  _image.size.height/2.0 - 5,
                                  _image.size.width,
                                  _image.size.height)];
    UILabel *btnTitle = [[UILabel alloc] initWithFrame:CGRectMake(RectWidth(rect)/2.0 - 30,
                                                                  RectHeight(rect)/2.0 + 20,
                                                                  60,
                                                                  20)];
    [btnTitle setText:text];
    [btnTitle setTextAlignment:NSTextAlignmentCenter];
    [btnTitle setFont:[UIFont boldSystemFontOfSize:14.0]];
    [btnTitle setTextColor:[UIColor lightGrayColor]];
    
    [mainPageBtn addSubview:btnImage];
    [mainPageBtn addSubview:btnTitle];
    
    return mainPageBtn;
}

@end
