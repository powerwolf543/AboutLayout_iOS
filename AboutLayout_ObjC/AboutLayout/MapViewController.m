//
//  MapViewController.m
//  AboutLayout
//
//  Created by NixonShih on 2017/1/19.
//  Copyright © 2017年 Nixon. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MapViewController {
    BOOL isFirst;
    NSTimer *timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareMapView];
}

#pragma mark - UI

- (void)prepareMapView {
    _mapView.delegate = self;
}

#pragma mark - geocoder

- (void)showAddressWithCoordinate:(CLLocationCoordinate2D)coordinate {
    
    if (_loadingView.hidden) {
        _loadingView.hidden = false;
        [_loadingView startAnimating];
    }
    
    CLGeocoder *geocoder = [CLGeocoder new];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (_addressLabel.hidden) _addressLabel.hidden = false;
        
        _loadingView.hidden = true;
        
        if (![self checkDataExistWithPlacemarks:placemarks andError:error]) {
            _addressLabel.text = @"未知";
            return;
        }
        
        NSDictionary *dic = placemarks.firstObject.addressDictionary;
        NSString *detail = dic[@"Name"] ? [NSString stringWithFormat:@", %@",dic[@"Name"]] : @"";
        NSString *address = [NSString stringWithFormat:@"%@, %@, %@%@",dic[@"Country"],dic[@"SubAdministrativeArea"],dic[@"City"],detail];
        _addressLabel.text = address;
        
        NSLog(@"%@", dic);
    }];
}

- (BOOL)checkDataExistWithPlacemarks:(NSArray<CLPlacemark *>*)placemarks
                            andError:(NSError*)error {
    
    if (error || placemarks.count == 0) return false;
    
    NSDictionary *dic = placemarks.firstObject.addressDictionary;
    
    if (dic[@"Country"] && dic[@"SubAdministrativeArea"] && dic[@"City"]) return true;
    
    return false;
}

#pragma mark - MKMapViewDelegate

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    if (!isFirst) {
        isFirst = true;
        [self showAddressWithCoordinate:mapView.centerCoordinate];
    }
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f repeats:false block:^(NSTimer * _Nonnull timer) {
        [self showAddressWithCoordinate:mapView.centerCoordinate];
    }];
}

@end
