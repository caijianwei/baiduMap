//
//  BaiDuViewController.h
//  baiduMap
//
//  Created by 田地 on 13-7-24.
//  Copyright (c) 2013年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaiDuViewController : UIViewController<BMKMapViewDelegate>

@property(nonatomic,strong)IBOutlet BMKMapView *mapView;
- (IBAction)start:(id)sender;

- (IBAction)stop:(id)sender;
@end
