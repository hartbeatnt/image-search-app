//
//  CancelButtonView.swift
//  image-search
//
//  Created by Nate Hart on 2/11/22.
//

import SwiftUI

struct SearchCancelButtonView: View {
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        Button("Cancel") {
            UIApplication.shared.dismissKeyboard()
            withAnimation {
                searchText = ""
                searching = false
            }
        }
    }
}

struct SearchCancelButtonView_Previews: PreviewProvider {
    @State static var searchText = ""
    @State static var searching = false

    static var previews: some View {
        SearchCancelButtonView(searchText: $searchText, searching: $searching)
    }
}
