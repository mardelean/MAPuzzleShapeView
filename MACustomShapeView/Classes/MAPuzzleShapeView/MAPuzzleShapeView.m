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
    
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    if (UIViewShapeAlignmentNone == self.shapeAlignment) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    
    if (self.shapeAlignment & UIViewShapeAlignmentLeft) {
        [self createShapeForContext:context
                    withCenterOfArc:CGPointMake(0.f, height / 2.f)
                      andAnglePoint:CGPointMake(M_PI_2, -M_PI_2)];
    }
    
    if (self.shapeAlignment & UIViewShapeAlignmentRight) {
        [self createShapeForContext:context
                    withCenterOfArc:CGPointMake(width, height / 2.f)
                      andAnglePoint:CGPointMake(-M_PI_2, M_PI_2)];
    }

    if (self.shapeAlignment & UIViewShapeAlignmentTop) {
        [self createShapeForContext:context
                    withCenterOfArc:CGPointMake(width / 2.f, 0)
                      andAnglePoint:CGPointMake(M_PI, 0)];
    }

    if (self.shapeAlignment & UIViewShapeAlignmentBottom) {
        [self createShapeForContext:context
                    withCenterOfArc:CGPointMake(width / 2.f, height)
                      andAnglePoint:CGPointMake(0, M_PI)];
    }
    
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
}

#pragma mark - Properties

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
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
- (void)createShapeForContext:(CGContextRef)context withCenterOfArc:(CGPoint)center andAnglePoint:(CGPoint)anglePoint {
    CGFloat radius = self.shapeLength / 2.f;
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddArc(context,
                    center.x,
                    center.y,
                    radius,
                    anglePoint.x,
                    anglePoint.y,
                    1);
}

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
