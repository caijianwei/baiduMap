//
//  BaiDuViewController.m
//  baiduMap
//
//  Created by 田地 on 13-7-24.
//  Copyright (c) 2013年 com.isoftstone. All rights reserved.
//

#import "BaiDuViewController.h"

@interface BaiDuViewController (){
//    CLLocationCoordinate2D coors[];

}

@end

@implementation BaiDuViewController

- (void)viewDidLoad
{
    self.mapView.delegate = self;
//    self.mapView.mapType = BMKMapTypeSatellite;
    
    [super viewDidLoad];
   

	// Do any additional setup after loading the view, typically from a nib.
}
-(void)drawLine:(BMKUserLocation *)userLocation{
    static int i =0;
    static CLLocationCoordinate2D coors[100000] = {};
     NSLog(@"%d",i);
    coors[i].longitude = userLocation.location.coordinate.longitude;
    coors[i].latitude = userLocation.location.coordinate.latitude;
    if (i>2) {
        BMKPolyline *line = [BMKPolyline polylineWithCoordinates:coors count:++i];
//        NSLog(@"%d",i);
        [self.mapView addOverlay:line];
    }else{
        ++i;
    }
    

}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay  isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay] ;
        polylineView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 10.0;
		return polylineView;
    }
    return nil;

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





- (IBAction)start:(id)sender {
    self.mapView.showsUserLocation = YES;
    
}

- (IBAction)stop:(id)sender {
    
    self.mapView.showsUserLocation = NO;
}
- (void)viewDidUnload {
    
    [self setMapView:nil];
    [super viewDidUnload];
}
@end
