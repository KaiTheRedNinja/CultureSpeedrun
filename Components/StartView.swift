//
//  StartView.swift
//  CultureSpeedrun
//
//  Created by Kai Quan Tay on 6/4/23.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

let locations = [
    Location(name: "Ho Chi Minh", coordinate: CLLocationCoordinate2D(latitude: 10.7, longitude: 106.5)),
    Location(name: "Chengdu", coordinate: CLLocationCoordinate2D(latitude: 30.5, longitude: 104)),
    Location(name: "Bangkok", coordinate: CLLocationCoordinate2D(latitude: 13.7, longitude: 100.4))
]

struct StartView: View {
    var nextPage: () -> Void

    init(nextPage: @escaping () -> Void) {
        self.nextPage = nextPage
        let mapCenter = CLLocationCoordinate2D(latitude: 22,
                                               longitude: 103.5)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
        self.mapRegion = MKCoordinateRegion(
            center: mapCenter,
            span: mapSpan
        )
    }

    @State private var mapRegion: MKCoordinateRegion

    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, interactionModes: .zoom, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Text(location.name)
                            .font(.title)
                            .bold()
                            .padding(5)
                            .background {
                                Color.primary.colorInvert()
                                    .cornerRadius(5)
                            }
                        Image(systemName: "pin.fill")
                            .foregroundColor(.red)
                    }
                    .offset(y: -30)
                }
            }
            .ignoresSafeArea()

            Color.white
                .frame(width: 350, height: 300)
                .cornerRadius(50)
                .opacity(0.8)
                .overlay {
                    VStack {
                        Spacer()
                        Text("Culture Speedrun")
                            .font(.largeTitle)
                        Text("Around the Region in 3 Minutes")
                            .font(.title2)

                        Spacer()

                        Button {
                            nextPage()
                        } label: {
                            Text("START")
                                .padding(.horizontal, 60)
                                .padding(.vertical, 20)
                        }
                        .buttonStyle(.borderedProminent)
                        Spacer()
                    }
                }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(nextPage: {})
    }
}
