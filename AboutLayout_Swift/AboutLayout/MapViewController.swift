//
//  MapViewController.swift
//  AboutLayout
//
//  Created by NixonShih on 2017/1/20.
//  Copyright © 2017年 Nixon. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet fileprivate weak var mapView: MKMapView!
    @IBOutlet fileprivate weak var loadingView: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var addressLabel: UILabel!
    fileprivate var isFirst = false
    fileprivate var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareMapView()
    }
    
    // MARK: - UI
    
    fileprivate func prepareMapView() {
        mapView.delegate = self
    }
    
    // MARK: - geocoder
    
    fileprivate func showAddress(with coordinate: CLLocationCoordinate2D) {
        
        if loadingView.isHidden {
            loadingView.isHidden = false
            loadingView.startAnimating()
        }
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude,
                                  longitude: coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            
            if self.addressLabel.isHidden { self.addressLabel.isHidden = false }
            
            self.loadingView.isHidden = true
            
            if !self.checkDataExist(with: placemarks, error: error) {
                self.addressLabel.text = "未知"
                return
            }
            
            let dic = (placemarks?.first?.addressDictionary)!
            let detail = dic["Name"] == nil ? "" : ", \(dic["Name"]!)"
            let address = "\(dic["Country"]!), \(dic["SubAdministrativeArea"]!), \(dic["City"]!)\(detail)"
            self.addressLabel.text = address
            
            print("\(dic)")
        }
    }
    
    fileprivate func checkDataExist(with placemarks: [CLPlacemark]?, error: Error?) -> Bool {
        
        if error != nil { return false }
        
        guard let dic = placemarks?.first?.addressDictionary else {
            return false
        }
        
        if dic["Country"] != nil &&
            dic["SubAdministrativeArea"] != nil &&
            dic["City"] != nil {
            return true
        }
        
        return false
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        
        if !isFirst {
            isFirst = true
            showAddress(with: mapView.centerCoordinate)
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (aTimer) in
            self.showAddress(with: mapView.centerCoordinate)
        })
    }
}
