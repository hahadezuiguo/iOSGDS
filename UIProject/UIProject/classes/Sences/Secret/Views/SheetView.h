//
//  SheetView.h
//  UIProject
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SheetViewDelegate <NSObject>

- (void)selectedRow:(NSInteger)index;

@end

@interface SheetView : UIView<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *myTable;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) id<SheetViewDelegate> delegate;

- (instancetype)initWithInforArray:(NSArray *)infors;

- (void)showInView:(UIViewController *)Sview;



@end
