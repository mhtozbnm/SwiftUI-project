//
//  ImageCache.swift
//  onlinesanalstoreSwiftUI
//
//  Created by Mahmut on 30.05.2024.
//

import SwiftUI
import Combine

class ImageCache {
    static let shared = ImageCache()
    
    private var cache = NSCache<NSString, UIImage>()
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

struct URLImage: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Image
    
    init(url: String, placeholder: Image = Image(systemName: "photo")) {
        self.placeholder = placeholder
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        image
            .onAppear(perform: loader.load)
    }
    
    private var image: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                placeholder
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var url: String
    private var cancellable: AnyCancellable?
    
    init(url: String) {
        self.url = url
    }
    
    func load() {
        if let cachedImage = ImageCache.shared.getImage(forKey: url) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: self.url) else {
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self, let image = $0 else { return }
                ImageCache.shared.setImage(image, forKey: self.url)
                self.image = image
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
