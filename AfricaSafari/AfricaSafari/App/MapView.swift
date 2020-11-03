import SwiftUI
import MapKit

struct MapView: View {
    // MARK:- Properties
    @State private var region: MKCoordinateRegion = {
        var mapCoordinates = CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.4377599)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 70.0, longitudeDelta: 70.0)
        var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
        return mapRegion
    }()
    
    let locations: [NationalParkLocation] = Bundle.main.decode("locations.json")
    
    // MARK:- Body
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations) { item in
            MapAnnotation(coordinate: item.location) {
                MapAnnotationView(location: item)
            }
        }
    }
}

// MARK:- Preview
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
