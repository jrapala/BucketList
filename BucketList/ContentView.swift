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
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
