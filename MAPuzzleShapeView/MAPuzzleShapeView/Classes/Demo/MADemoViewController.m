//
//  ViewController.m
//  MACustomShapeView
//
//  Created by Madalina Ardelean on 12/9/14.
//  Copyright (c) 2014 Madalina Ardelean. All rights reserved.
//

#import "MADemoViewController.h"
#import "MAPuzzleShapeView.h"

@interface MADemoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *shapeSides;

@property (nonatomic, strong) MAPuzzleShapeView *puzzleShapeView;
@property (nonatomic, strong) CATextLayer *textLayer;

@end

@implementation MADemoViewController

static NSString *kCellIdentifier = @"CellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.puzzleShapeView];
    [self.puzzleShapeView.contentView.layer addSublayer:self.textLayer];
    
    self.shapeSides = @[@"Left", @"Right", @"Top", @"Bottom"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    const CGFloat drawingZoneHeight = 300.f;
    
    const CGFloat puzzleViewWidth = 250.f;
    const CGFloat puzzleViewHeight = 150.f;
    CGFloat offsetX = (CGRectGetWidth(self.view.bounds) - puzzleViewWidth) / 2.f;
    CGFloat offsetY = (drawingZoneHeight - puzzleViewHeight) / 2.f;
    
    self.puzzleShapeView.frame = CGRectMake(offsetX, offsetY, puzzleViewWidth, puzzleViewHeight);
    self.tableView.frame = CGRectMake(.0f, drawingZoneHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - drawingZoneHeight);
    
    const CGFloat textHeight = 60.f;
    CGFloat textOffsetY = (CGRectGetHeight(self.puzzleShapeView.contentView.frame) - textHeight) / 2.f;
    self.textLayer.frame =  CGRectMake(.0f,
                                       textOffsetY,
                                       CGRectGetWidth(self.puzzleShapeView.contentView.frame),
                                       textHeight);
    
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.shapeSides count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    cell.textLabel.text = self.shapeSides[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @" Draw a puzzle shape:";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.f;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewShapeAlignment shapeAlignment = self.puzzleShapeView.shapeAlignment;
    switch (indexPath.row) {
        case 0:
            self.puzzleShapeView.shapeAlignment = shapeAlignment | UIViewShapeAlignmentLeft;
            break;
        case 1:
            self.puzzleShapeView.shapeAlignment = shapeAlignment | UIViewShapeAlignmentRight;
            break;
        case 2:
            self.puzzleShapeView.shapeAlignment = shapeAlignment | UIViewShapeAlignmentTop;
            break;
        case 3:
            self.puzzleShapeView.shapeAlignment = shapeAlignment | UIViewShapeAlignmentBottom;
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewShapeAlignment shapeAlignment = self.puzzleShapeView.shapeAlignment;
    switch (indexPath.row) {
        case 0:
            if (shapeAlignment & UIViewShapeAlignmentLeft) {
                self.puzzleShapeView.shapeAlignment = shapeAlignment & ~UIViewShapeAlignmentLeft;
            }
            break;
        case 1:
            if (shapeAlignment & UIViewShapeAlignmentRight) {
                self.puzzleShapeView.shapeAlignment = shapeAlignment & ~UIViewShapeAlignmentRight;
            }
            break;
        case 2:
            if (shapeAlignment & UIViewShapeAlignmentTop) {
                self.puzzleShapeView.shapeAlignment = shapeAlignment & ~UIViewShapeAlignmentTop;
            }
            break;
        case 3:
            if (shapeAlignment & UIViewShapeAlignmentBottom) {
                self.puzzleShapeView.shapeAlignment = shapeAlignment & ~UIViewShapeAlignmentBottom;
            }
            break;
        default:
            break;
    }
}

#pragma mark - Properties

- (MAPuzzleShapeView *)puzzleShapeView {
    if (!_puzzleShapeView) {
        _puzzleShapeView = [[MAPuzzleShapeView alloc] initWithFrame:CGRectZero];
        _puzzleShapeView.shapeLength = 40.f;
        _puzzleShapeView.shapeAlignment = UIViewShapeAlignmentNone;
        _puzzleShapeView.backgroundFillColor = [UIColor lightGrayColor];
    }
    return _puzzleShapeView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.allowsMultipleSelection = YES;
    }
    return _tableView;
}

- (CATextLayer *)textLayer {
    if (!_textLayer) {
        _textLayer = [CATextLayer layer];
        _textLayer.string = @"Welcome";
        _textLayer.font = (__bridge CFTypeRef)[UIFont fontWithName:@"Noteworthy-Light" size:24.f];
        _textLayer.foregroundColor = [UIColor redColor].CGColor;
        _textLayer.alignmentMode = kCAAlignmentCenter;
    }
    return _textLayer;
}

@end
