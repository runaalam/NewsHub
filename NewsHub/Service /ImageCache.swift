import Foundation
import SwiftUI

/// ImageCache is a class that conforms to ObservableObject and provides functionality to cache and retrieve images.
/// It uses NSCache to store image data and can be observed for changes in SwiftUI views.
class ImageCache: ObservableObject {
    // The cache object used to store image data.
    private var cache = NSCache<NSString, NSData>()
    
    /// Method to retrieve an Image from the cache based on a key.
    /// It takes the key as a string and returns an optional Image.
    func getImage(forKey key: String) -> Image? {
        // Try to get the cached data based on the provided key.
        if let cachedData = cache.object(forKey: NSString(string: key)) {
            // If the data is successfully retrieved, convert it to a UIImage and create an Image with it.
            if let uiImage = UIImage(data: cachedData as Data) {
                return Image(uiImage: uiImage)
            }
        }
        
        // Return nil if there is no cached data or if the data cannot be converted to an Image.
        return nil
    }
    
    /// Method to set an Image in the cache for a given key.
    /// It takes the image and the key as strings and caches the image data in NSCache.
    func setImage(_ image: Image, forKey key: String) {
        // Convert the SwiftUI Image to a UIImage.
        if let data = image.asUIImage().pngData() {
            
            // Cache the UIImage data in NSCache with the provided key.
            self.cache.setObject(data as NSData, forKey: NSString(string: key))
        }
    }
}

/// Image extension that provides a method to convert a SwiftUI Image to a UIImage.
/// It creates a UIHostingController to render the SwiftUI Image and then captures the rendered view as a UIImage.
extension Image {
    /// Method to convert SwiftUI Image to UIImage.
    /// It returns a UIImage representation of the SwiftUI Image.
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

