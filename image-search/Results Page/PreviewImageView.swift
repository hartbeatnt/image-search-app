//
//  PreviewImageView.swift
//  image-search
//
//  Created by Nate Hart on 2/13/22.
//

import SwiftUI

struct PreviewImageView: View {
    let url: URL
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        AsyncImage(url: url,
                   content: { format(image: $0) },
                   placeholder: { makePlaceholder() })
    }

    private func makePlaceholder() -> some View {
        ProgressView()
            .frame(maxWidth: 300, maxHeight: 100)
            .aspectRatio(width / height, contentMode: .fit)
    }

    private func format(image: Image) -> some View {
        image.resizable()
             .aspectRatio(width / height, contentMode: .fit)
             .frame(maxWidth: 300, maxHeight: 100)
    }
}

struct PreviewImageView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewImageView(url: URL(string: "example.com")!, width: 1, height: 1)
    }
}
