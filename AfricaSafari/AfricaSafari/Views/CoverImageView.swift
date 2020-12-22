import SwiftUI

struct CoverImageView: View {
    // MARK:- Properties
    let coverImages: [CoverImage] = Bundle.main.decode("covers.json")
    
    // MARK:- Body
    var body: some View {        
        AutoScrollView(imgArray: generateImageArray())
    }
    
    func generateImageArray() -> [UIImage] {
        var imgArr = [UIImage]()
        for image in coverImages {
            imgArr.append(UIImage(named: image.name)!)
        }
        return imgArr
    }
}

// MARK:- Preview
struct CoverImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoverImageView()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
