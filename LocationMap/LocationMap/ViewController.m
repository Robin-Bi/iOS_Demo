//
//  ViewController.m
//  LocationMap
//
//  Created by Rui on 2018/9/29.
//  Copyright © 2018年 Robin-Bi. All rights reserved.
//

#import "ViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface ViewController ()<AMapLocationManagerDelegate,AMapSearchDelegate>{
    NSString *latitudeStr; //纬度
    NSString *longtitudeStr; //经度
    AMapSearchAPI *search;
    AMapLocationManager *locationManager;
    NSString *LocationCity; //定位城市
    NSString *LatiLongtiStr; //纬度经度拼接字符串
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getCurrentLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取当前地理位置
- (void)getCurrentLocation{
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        search = [[AMapSearchAPI alloc]init];
        search.delegate = self;
        
        locationManager = [[AMapLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager startUpdatingLocation];
    }else {
        NSLog(@"定位没有开启");
    }
}

#pragma mark - AMapSearchDelegate
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSString *locationCity = @"";
    if (response.regeocode)
    {
        locationCity = response.regeocode.addressComponent.city;
    }
    LocationCity = locationCity;
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    latitudeStr = [NSString stringWithFormat:@"%lf",location.coordinate.latitude];
    longtitudeStr = [NSString stringWithFormat:@"%lf",location.coordinate.longitude];
    NSString *combineStr = [NSString stringWithFormat:@"%@/%@",latitudeStr,longtitudeStr];
    LatiLongtiStr = combineStr;
    
    [locationManager stopUpdatingLocation];
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    regeo.requireExtension = YES;
    //发起逆地理编码
    [search AMapReGoecodeSearch:regeo];
}


- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    latitudeStr = [NSString stringWithFormat:@"%lf",location.coordinate.latitude];
    longtitudeStr = [NSString stringWithFormat:@"%lf",location.coordinate.longitude];
    NSString *combineStr = [NSString stringWithFormat:@"%@/%@",latitudeStr,longtitudeStr];
    LatiLongtiStr = combineStr;
    
    [locationManager stopUpdatingLocation];
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    regeo.requireExtension = YES;
    //发起逆地理编码
    [search AMapReGoecodeSearch:regeo];
}



@end
