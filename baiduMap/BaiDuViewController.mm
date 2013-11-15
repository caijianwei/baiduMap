//
//  BaiDuViewController.m
//  baiduMap
//
//  Created by 田地 on 13-7-24.
//  Copyright (c) 2013年 com.isoftstone. All rights reserved.
//

#import "BaiDuViewController.h"

@interface BaiDuViewController ()

@end

@implementation BaiDuViewController

- (void)viewDidLoad
{
 
    
    [super viewDidLoad];
    self.mapView.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.mapView.showsUserLocation = YES;


}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.mapView.showsUserLocation = NO;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
	NSLog(@"start locate");
}

/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
	if (userLocation != nil) {
		NSLog(@"%f %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
        [self drawLine:userLocation];
	}
	
}


- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 1.0;
		return polylineView;
    }
    return nil;

}

-(void)drawLine:(BMKUserLocation *)userLocation{
   
    static int locationLineCount = 0;
    static CLLocationCoordinate2D location[1000000] = {};
    if (userLocation) {
        location[locationLineCount].latitude = userLocation.location.coordinate.latitude;
        location[locationLineCount].longitude = userLocation.location.coordinate.longitude;
        BMKPolyline *polyline = [BMKPolyline polylineWithCoordinates:location count:++locationLineCount];
        [self.mapView addOverlay:polyline];
    }
   




}



/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
}
/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}
- (IBAction)start:(id)sender{
    self.mapView.showsUserLocation = YES;
}

- (IBAction)stop:(id)sender{
self.mapView.showsUserLocation = NO;

}




@end
