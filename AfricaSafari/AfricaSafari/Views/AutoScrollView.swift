import SwiftUI

struct AutoScrollView: UIViewControllerRepresentable {

    
    typealias UIViewControllerType = ImageScrollViewController
    
    var imgArray: [UIImage]
    
    init(imgArray: [UIImage]) {
        self.imgArray = imgArray
    }
    
    func makeUIViewController(context: Context) -> ImageScrollViewController {
        let vc = ImageScrollViewController()
        vc.imgArr = imgArray
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ImageScrollViewController, context: Context) {
        uiViewController.imgArr = imgArray
    }
}


struct AutoScrollView_Previews: PreviewProvider {

    static func generateImgArray() -> [UIImage] {
        let coverImages: [CoverImage] = Bundle.main.decode("covers.json")
        var imgArr = [UIImage]()
        for image in coverImages {
            imgArr.append(UIImage(named: image.name)!)
        }
        return imgArr
    }
    
    static var previews: some View {
        AutoScrollView(imgArray: generateImgArray())
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 12 mini")
    }
}
