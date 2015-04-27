//
//  MAPuzzleShapeView.m
//  MACustomShapeView
//
//  Created by Madalina Ardelean on 12/9/14.
//  Copyright (c) 2014 Madalina Ardelean. All rights reserved.
//

#import "MAPuzzleShapeView.h"

@implementation MAPuzzleShapeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.shapeLength = 0.f;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundFillColor = [UIColor darkGrayColor];
        self.strokeColor = [UIColor darkGrayColor];
        self.lineWidth = 0.f;
        self.shapeAlignment = UIViewShapeAlignmentOnX;
        
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = [self frameForContentView];
    [self.superview setNeedsLayout];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.backgroundFillColor setFill];
    [self.strokeColor setStroke];
    
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    CGFloat radius = self.shapeLength / 2.f;
    CGFloat leftRightValue = (height - self.shapeLength) / 2.f;
    CGFloat topBottomValue = (width - self.shapeLength) / 2.f;

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth:self.lineWidth];
    [path moveToPoint:CGPointMake(.0f, .0f)];
    
    if (self.shapeAlignment & UIViewShapeAlignmentLeft) {
        [path addLineToPoint:CGPointMake(.0f, leftRightValue)];
        [path addArcWithCenter:CGPointMake(.0f, leftRightValue + radius)
                        radius:radius
                    startAngle:-M_PI_2
                      endAngle:M_PI_2
                     clockwise:YES];
    }
    [path addLineToPoint:CGPointMake(.0f, height)];
    
    if (self.shapeAlignment & UIViewShapeAlignmentBottom) {
        [path addLineToPoint:CGPointMake(topBottomValue, height)];
        [path addArcWithCenter:CGPointMake(topBottomValue + radius, height)
                        radius:radius
                    startAngle:-M_PI
                      endAngle:0
                     clockwise:YES];
    }
    [path addLineToPoint:CGPointMake(width, height)];
    
    if (self.shapeAlignment & UIViewShapeAlignmentRight) {
        [path addLineToPoint:CGPointMake(width, height - leftRightValue)];
        [path addArcWithCenter:CGPointMake(width, leftRightValue + radius)
                        radius:radius
                    startAngle:M_PI_2
                      endAngle:-M_PI_2
                     clockwise:YES];
    }
    [path addLineToPoint:CGPointMake(width, 0.f)];
    
    if (self.shapeAlignment & UIViewShapeAlignmentTop) {
        [path addLineToPoint:CGPointMake(width - topBottomValue, 0.f)];
        [path addArcWithCenter:CGPointMake(topBottomValue + radius, 0.f)
                        radius:radius
                    startAngle:0
                      endAngle:M_PI
                     clockwise:YES];
    }
    
    [path closePath];
    [path fill];
    [path stroke];

}

#pragma mark - Properties

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.autoresizesSubviews = YES;
    }
    return _contentView;
}

- (void)setShapeAlignment:(UIViewShapeAlignment)shapeAlignment {
    _shapeAlignment = shapeAlignment;
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

#pragma mark - Private methods

- (CGRect)frameForContentView {
    CGFloat offsetLeft = 0.f;
    CGFloat offsetRight = 0.f;
    CGFloat offsetTop = 0.f;
    CGFloat offsetBottom = 0.f;
    
    if (self.shapeAlignment & UIViewShapeAlignmentLeft) {
        offsetLeft = self.shapeLength / 2.f;
    }
    
    if (self.shapeAlignment & UIViewShapeAlignmentRight) {
        offsetRight = self.shapeLength / 2.f;
    }
    
    if (self.shapeAlignment & UIViewShapeAlignmentTop) {
        offsetTop = self.shapeLength / 2.f;
    }
    
    if (self.shapeAlignment & UIViewShapeAlignmentBottom) {
        offsetBottom = self.shapeLength / 2.f;
    }
    CGFloat width = CGRectGetWidth(self.bounds) - offsetLeft - offsetRight;
    CGFloat height = CGRectGetHeight(self.bounds) - offsetTop - offsetBottom;
    
    return CGRectMake(offsetLeft, offsetTop, width, height);
}

@end
