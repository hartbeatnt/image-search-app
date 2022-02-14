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
        NavigationLink(destination: ImageDetailPageView(url: url)) {
            GeometryReader { geometry in
                AsyncImage(url: url,
                           content: { format(image: $0, with: geometry) },
                           placeholder: { makePlaceholder(for: geometry) })
            }
            .clipped()
            .aspectRatio(1, contentMode: .fit)
        }
    }

    private func makePlaceholder(for geometry: GeometryProxy) -> some View {
        return ProgressView()
            .frame(width: geometry.size.width)
            .padding(.init(top: geometry.size.width / 2, leading: 0, bottom: 0, trailing: 0))
    }

    private func format(image: Image, with geometry: GeometryProxy) -> some View {
        image.resizable()
             .scaledToFill()
             .frame(width: geometry.size.width, alignment: .center)
    }
}

struct PreviewImageView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewImageView(url: URL(string: "example.com")!)
    }
}
