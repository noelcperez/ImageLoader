//
//  ImageLoaderApp.swift
//  ImageLoader
//
//  Created by Noel C Perez on 9/25/21.
//

import SwiftUI

@main
struct ImageLoaderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(source: URL(string: "http://www.publicdomainpictures.net/pictures/320000/velka/background-image.png")!)
        }
    }
}
