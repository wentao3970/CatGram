//
//  LazyView.swift
//  CatGram
//
//  Created by Wentao on 1/19/21.
//

import Foundation
import SwiftUI

struct LazyView<Content: View> : View {
    
    var content: () -> Content
    
    var body: some View {
        self.content()
    }
}
