//
//  ContentView.swift
//  image-search
//
//  Created by Nate Hart on 2/9/22.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        NavigationView { SearchPageView() }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
