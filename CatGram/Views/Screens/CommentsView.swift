//
//  CommentsView.swift
//  CatGram
//
//  Created by Wentao on 1/14/21.
//

import SwiftUI

struct CommentsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var submissionText: String = ""
    @State var commentArray = [CommentModel]()
    var body: some View {
        VStack {
            
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                LazyVStack {
                    ForEach(commentArray) { comment in
                        MessageView(comment: comment)
                    }
                }
            })
            .navigationBarTitle("COMMENTS")
            .navigationBarTitleDisplayMode(.inline)
            
            HStack {
                Image("dog1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(20)
                
                TextField("Add a comment here...", text: $submissionText)
                Button(action: {
                    
                }, label: {
                    Image(systemName: "paperplane.fill")
                })
                .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
            }
            .padding(.all, 6)
        }
        .padding()
        .navigationBarTitle("Commnets")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            getComments()
        })
    }
    
    // MARK: FUNCTIONS
    
    func getComments() {
        
        print("GET COMMNETS FROM DTATBASE")
        
        let comment1 = CommentModel(commentID: "", userID: "", username: "Wentao", content: "This is the first comment", dateCreated: Date())
        
        let comment2 = CommentModel(commentID: "", userID: "", username: "Xiaoyu", content: "This is the first comment", dateCreated: Date())
        
        let comment3 = CommentModel(commentID: "", userID: "", username: "AA", content: "This is the first comment", dateCreated: Date())
        
        let comment4 = CommentModel(commentID: "", userID: "", username: "BB", content: "This is the first comment", dateCreated: Date())
        
        self.commentArray.append(comment1)
        self.commentArray.append(comment2)
        self.commentArray.append(comment3)
        self.commentArray.append(comment4)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {            
            CommentsView()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
