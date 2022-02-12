//
//  UIApplication+Extensions.swift
//  image-search
//
//  Created by Nate Hart on 2/11/22.
//

import UIKit

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
