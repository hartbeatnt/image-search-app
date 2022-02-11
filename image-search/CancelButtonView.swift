//
//  CancelButtonView.swift
//  image-search
//
//  Created by Nate Hart on 2/11/22.
//

import SwiftUI

struct CancelButtonView: View {
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        Button("Cancel") {
            searchText = ""
            withAnimation {
                searching = false
                UIApplication.shared.dismissKeyboard()
            }
        }
    }
}

struct CancelButtonView_Previews: PreviewProvider {
    @State static var searchText = ""
    @State static var searching = false

    static var previews: some View {
        CancelButtonView(searchText: $searchText, searching: $searching)
    }
}
