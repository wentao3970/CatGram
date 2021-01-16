//
//  SettingsLabelView.swift
//  CatGram
//
//  Created by Wentao on 1/15/21.
//

import SwiftUI

struct SettingsLabelView: View {
    
    var labelText: String
    var labelImage: String
    
    var body: some View {
        VStack {
            HStack {
                
                Text(labelText)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                Image(systemName: labelImage)
                
            }
            
            Divider()
                .padding(.vertical, 4)
            
        }
    }
}

struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(labelText: "Test Label", labelImage: "heart")
            .previewLayout(.sizeThatFits)
    }
}
