import SwiftUI

struct GalleryView: View {
    
    // MARK:- Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text("Placeholder")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(MotionAnimationView())
    }
}

// MARK:- Preview
struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
            .previewDevice("iPhone 11")
    }
}
