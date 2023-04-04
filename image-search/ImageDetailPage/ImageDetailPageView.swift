//
//  ImageDetailPageView.swift
//  image-search
//
//  Created by Nate Hart on 2/13/22.
//

import SwiftUI

struct ImageDetailPageView: View {
    let url: URL
    let images: [ImgurApi.Image]
    let index: Int
    @State var isNavigating = false
    @State var nextUrl = URL(string: "example.com")!
    @State var nextIndex = 0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationLink(
            destination: ImageDetailPageView(url: nextUrl, images: images, index: nextIndex, presentationMode: _presentationMode),
            isActive: $isNavigating
        ) { EmptyView() }

        ScrollView {
            AsyncImage(url: url,
                       content: { format(image: $0) },
                       placeholder: { ProgressView() })
                .gesture(DragGesture(minimumDistance: 5, coordinateSpace: .local).onEnded { value in
                    if value.translation.width > 100 {
                        nextIndex = index + 1
                    } else {
                        nextIndex = index - 1
                    }
                    nextUrl = images[nextIndex].link
                    isNavigating = true
                })
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }

    private func format(image: Image) -> some View {
        image.resizable()
             .scaledToFill()
             .padding()
    }

    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image("ic_back") // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    Text("Go back")
                }
            }
        }
}

struct ImageDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailPageView(url: URL(string: "example.com")!, images: [], index: 0)
    }
}
