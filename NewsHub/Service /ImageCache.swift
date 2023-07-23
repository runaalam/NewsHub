import Foundation
import SwiftUI

class ImageCache: ObservableObject {
    private var cache = NSCache<NSString, NSData>()
    
    func getImage(forKey key: String) -> Image? {
        if let cachedData = cache.object(forKey: NSString(string: key)) {
            if let uiImage = UIImage(data: cachedData as Data) {
                return Image(uiImage: uiImage)
            }
        }
        return nil
    }
    
    func setImage(_ image: Image, forKey key: String) {
        if let data = image.asUIImage().pngData() {
            self.cache.setObject(data as NSData, forKey: NSString(string: key))
        }
    }
}

extension Image {
    // Convert SwiftUI Image to UIImage
    func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

