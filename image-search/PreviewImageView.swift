//
//  PreviewImageView.swift
//  image-search
//
//  Created by Nate Hart on 2/13/22.
//

import SwiftUI

struct PreviewImageView: View {
    let url: URL
    var body: some View {
        AsyncImage(url: url,
                   content: { format(image: $0) },
                   placeholder: { ProgressView() })
    }

    private func format(image: Image) -> some View {
        image.resizable()
             .aspectRatio(contentMode: .fit)
             .frame(maxWidth: 300, maxHeight: 100)
    }
}

struct PreviewImageView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewImageView(url: URL(string: "example.com")!)
    }
}
