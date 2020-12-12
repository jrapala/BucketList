//
//  ContentView.swift
//  BucketList
//
//  Created by Juliette Rapala on 12/7/20.
//

import SwiftUI
import MapKit

struct ContentView: View {
    // Store the center coordinate of the map
    @State private var centerCoordinate = CLLocationCoordinate2D()
    // Store array of locations
    @State private var locations = [MKPointAnnotation]()
    // Store selected place
    @State private var selectedPlace: MKPointAnnotation?
    // Store place details
    @State private var showingPlaceDetails = false
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = MKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        newLocation.title = "Home sweet home"
                        self.locations.append(newLocation)
                    }) {
                        Image(systemName: "plus")
                    }
                    // add padding to make button bigger before background color
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    // add padding to move it away from edge
                    .padding(.trailing)
                }
            }
        }
        .alert(isPresented: $showingPlaceDetails) {
            // temporarily show alert with title and subtitle of currently selected place
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                // edit this place
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
