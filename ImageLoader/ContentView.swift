//
//  ContentView.swift
//  ImageLoader
//
//  Created by Noel C Perez on 9/25/21.
//

import SwiftUI

struct ImageLoaderKey: EnvironmentKey {
    static let defaultValue = ImageLoader()
}

extension EnvironmentValues {
    var imageLoader: ImageLoader {
            get { self[ImageLoaderKey.self] }
            set { self[ImageLoaderKey.self ] = newValue}
        }
}

struct ContentView: View {
    private let source: URLRequest
    @State private var image: UIImage?

    @Environment(\.imageLoader) private var imageLoader

    init(source: URL) {
        self.init(source: URLRequest(url: source))
    }

    init(source: URLRequest) {
        self.source = source
    }
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
            } else {
                Rectangle()
                    .background(Color.red)
            }
        }
        .task {
            await loadImage(at: source)
        }
    }
    
    func loadImage(at source: URLRequest) async {
        do {
            image = try await imageLoader.fetch(source)
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(source: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png")!)
    }
}
