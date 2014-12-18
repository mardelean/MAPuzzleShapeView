//
//  MAPuzzleShapeView.h
//  MACustomShapeView
//
//  Created by Madalina Ardelean on 12/9/14.
//  Copyright (c) 2014 Madalina Ardelean. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIViewShapeAlignment) {
    UIViewShapeAlignmentNone = 0,
    UIViewShapeAlignmentTop = 1 << 0,
    UIViewShapeAlignmentBottom = 1 << 1,
    UIViewShapeAlignmentLeft = 1 << 2,
    UIViewShapeAlignmentRight = 1 << 3,
    UIViewShapeAlignmentOnX = UIViewShapeAlignmentLeft | UIViewShapeAlignmentRight,
    UIViewShapeAlignmentOnY = UIViewShapeAlignmentTop | UIViewShapeAlignmentBottom,
    UIViewShapeAlignmentAll = UIViewShapeAlignmentOnX | UIViewShapeAlignmentOnY
    
};

@interface MAPuzzleShapeView : UIView
/*
 * This shape alignment will draw a puzzle shape on the selected sides.
 * For example if the shapeAlignment is set to UIViewShapeAlignmentOnY,there will be 2 puzzle shapes on the top and on the bottom sides of the view.
 *
 * The default shape alignment will be on X axis
 */
@property (nonatomic, assign) UIViewShapeAlignment shapeAlignment;

/*
 * If not set the default value will be 0, so no shape will be drawn
 */
@property (nonatomic, assign) CGFloat shapeLength;

/*
 * Please add any content on this contentView. It will have the size of the view excluding the shape size.
 */
@property (nonatomic, strong) UIView *contentView;

/*
 * The default color will be darkGray
 */
@property (nonatomic, strong) UIColor *backgroundFillColor;

/*
 * The default value will be 0
 */
@property (nonatomic, assign) CGFloat lineWidth;
/*
 * The default color will be darkGray
 */
@property (nonatomic, strong) UIColor *strokeColor;

@end
