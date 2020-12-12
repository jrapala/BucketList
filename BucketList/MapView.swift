//
//  MapView.swift
//  BucketList
//
//  Created by Juliette Rapala on 12/10/20.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    // Order matters for parameters!!
    
    // Data is passed from MapKit to the coordinator to a @Binding
    @Binding var centerCoordinate: CLLocationCoordinate2D
    // Track the place that was selected
    @Binding var selectedPlace: MKPointAnnotation?
    // Track whether to show details
    @Binding var showingPlaceDetails: Bool

    // hold all locations passed to MapView
    var annotations: [MKPointAnnotation]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        if annotations.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        // Get boilerplate by typing in "viewfor"
        // We use this to provide a custom view to represent our map pin
        // Here we will add a button that can be tapped for more information
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // This is our unique identifier for view reuse
            // View are expensive. Let's just change the text.
            let identifier = "Placemark"
            
            // Attempt to find a cell we can recycle
            // The dequeue method lets us reuse a a view if available. If not, we get nil.
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                // We didn't find a view. Make a new one.
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                // Allow it to show pop up information
                annotationView?.canShowCallout = true
                
                // Attach an information button to the view
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                // We have a view to reuse, so give it a new annotation
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let placemark = view.annotation as? MKPointAnnotation else { return }
            
            parent.selectedPlace = placemark
            parent.showingPlaceDetails = true
        }
    }
}
    
// Extend MKPointAnnotation to make the MapView Preview work
extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(false), annotations: [MKPointAnnotation.example])
    }
}
