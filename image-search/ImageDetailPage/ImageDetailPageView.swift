//
//  ImageDetailPageView.swift
//  image-search
//
//  Created by Nate Hart on 2/13/22.
//

import SwiftUI

struct ImageDetailPageView: View {
    let url: URL
    var body: some View {
        ScrollView {
            AsyncImage(url: url,
                       content: { format(image: $0) },
                       placeholder: { ProgressView() })
        }
    }

    private func format(image: Image) -> some View {
        image.resizable()
             .scaledToFill()
             .padding()
    }
}

struct ImageDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailPageView(url: URL(string: "example.com")!)
    }
}
