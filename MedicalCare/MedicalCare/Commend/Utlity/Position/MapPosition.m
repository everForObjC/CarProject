//
//  MapPosition.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/16.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "MapPosition.h"
#import <MapKit/MapKit.h>

@interface MapPosition()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView * mapV;
}

@property (nonatomic,strong) CLLocationManager * manager;
@property (nonatomic,assign) CLLocationCoordinate2D c2d;

@end

@implementation MapPosition

- (CLLocationCoordinate2D)getLocation{

    mapV = [[MKMapView alloc]init];
    mapV.delegate = self;
    [self.manager startUpdatingLocation];
    return self.c2d;
}

- (CLLocationManager *)manager{

    if (!_manager) {
        
        _manager = [[CLLocationManager alloc]init];
        _manager.distanceFilter = kCLDistanceFilterNone;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [_manager requestAlwaysAuthorization];
        }
    }
    return _manager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

    CLLocation * location = [locations lastObject];
    
    self.c2d = location.coordinate;

}
@end
