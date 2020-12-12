//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Juliette Rapala on 12/12/20.
//

import MapKit

// MKPointAnnotation uses optional strings for title and subtitle, and SwiftUI doesn’t let us bind optionals to text fields.
// We need to extend MKPointAnnotation to compute properties
extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }
        
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }
        
        set {
            subtitle = newValue
        }
    }
}
