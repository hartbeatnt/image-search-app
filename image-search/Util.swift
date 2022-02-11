//
//  Util.swift
//  image-search
//
//  Created by Nate Hart on 2/11/22.
//

import SwiftUI

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
