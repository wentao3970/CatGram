//
//  BrowserView.swift
//  CatGram
//
//  Created by Wentao on 1/15/21.
//

import SwiftUI

struct BrowserView: View {
    
    var posts = PostArrayObject()
    
    var body: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
            CarouselView()
            ImageGridView (posts: posts)
        })
        .navigationBarTitle("Browse")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BrowserView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BrowserView()
        }
    }
}
