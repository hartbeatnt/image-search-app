//
//  ResultView.swift
//  image-search
//
//  Created by Nate Hart on 2/9/22.
//

import SwiftUI

struct ResultView: View {
    var query: String
    
    var body: some View {
        Text(query)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(query: "")
    }
}
