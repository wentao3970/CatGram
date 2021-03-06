//
//  PostView.swift
//  CatGram
//
//  Created by Wentao on 1/14/21.
//

import SwiftUI

struct PostView: View {
    
    @State var post: PostModel
    var showHeaderAndFooter: Bool
    
    @State var animateLike: Bool = false
    @State var addheartAnimationToView: Bool
    
    @State var showActionSheet: Bool = false
    
    @State var actionSheetType: PostActionSheetOption = .general
    
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    @State var postImage: UIImage = UIImage(named: "logo.loading")!
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    
    // Alerts
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var showAlert: Bool = false
    
    
    enum PostActionSheetOption {
        case general
        case reporting
    }
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
            
            // MARK: HEADER
            if showHeaderAndFooter {
                
                HStack {
                    
                    NavigationLink (
                        destination: LazyView(content : {
                            ProfileView(isMyProfile: false, profileDisplayName: post.username, profileUserID: post.userID, posts: PostArrayObject(userID: post.userID))
                        }),
                        label: {
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(15)
                            
                            Text(post.username)
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        })
                        
                    Spacer()
                    
                    
                    Button(action: {
                        showActionSheet.toggle()
                    }, label: {
                        Image(systemName: "ellipsis")
                            .font(.headline)
                    })
                    .accentColor(.black)
                    .actionSheet(isPresented: $showActionSheet, content: {
                        getActionSheet()
                    })
                }
                .padding(.all, 6)
            }
            
            // MARK: IMAGE
            ZStack {
                
                Image(uiImage: postImage)
                    .resizable()
                    .scaledToFit()
                    .onTapGesture(count: 2) {
                        if !post.likedByUser {
                            likePost()
                            AnalyticsService.instance.likePostDoubleTap()
                        }
                    }
                
                if addheartAnimationToView{
                    LikeAnimationView(animate: $animateLike)
                }
                
            }
            
            
            // MARK: FOOTER
            if showHeaderAndFooter {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20, content: {
                    
                    Button (action: {
                        if post.likedByUser {
                            //unlike
                            unlikePost()
                        } else {
                            // like
                            likePost()
                            AnalyticsService.instance.likePostHeartPressed()
                        }
                    }, label: {
                        Image(systemName: post.likedByUser ? "heart.fill" : "heart")
                            .font(.title3)
                    })
                    .accentColor(post.likedByUser ? .red : .primary)
                    
                    // MARK: COMMENT ICON
                    NavigationLink(
                        destination: CommentsView(post: post),
                        label: {
                            Image(systemName: "bubble.middle.bottom")
                                .font(.title3)
                                .foregroundColor(.primary)
                        })
                    
                    Button(action: {
                        sharePost()
                    }, label: {
                        Image(systemName: "paperplane")
                            .font(.title3)
                    })
                    .accentColor(.primary)
                    
                    Spacer()
                })
                .padding(.all, 6)
                
                if let caption = post.caption {
                    HStack {
                        Text(caption)
                        
                        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.all, 6)
                }
            }
        })
        .onAppear{
            getImages()
        }
        .alert(isPresented: $showAlert) { () -> Alert in
            return Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // MARK : FUNCTIONS
    
    func likePost() {
        
        guard let userID = currentUserID else {
            print("Cannot find userID while liking post")
            return
        }
        
        // update the local data
        let updatePost = PostModel(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreated: post.dateCreated, likeCount: post.likeCount + 1, likedByUser: true)
        self.post = updatePost
        
        // Animate UI
        animateLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            animateLike = false
        }
        
        // Update the database
        DataService.instance.likePost(postID: post.postID, currentUserID: userID)
    }
    
    func unlikePost() {
        
        guard let userID = currentUserID else {
            print("Cannot find userID while unliking post")
            return
        }
        
        // update the local data
        let updatePost = PostModel(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreated: post.dateCreated, likeCount: post.likeCount - 1, likedByUser: false)
        self.post = updatePost
        
        // Update the database
        DataService.instance.unlikePost(postID: post.postID, currentUserID: userID)
    }
    
    func getImages() {
        
        // Get profile image
        ImageManager.instance.downloadProfileImage(userID: post.userID) { (returnedImage) in
            if let image = returnedImage {
                self.profileImage = image
            }
        }
        
        // Get post image
        ImageManager.instance.downloadPostImage(postID: post.postID) { (returnedImage) in
            if let image = returnedImage {
                self.postImage = image
            }
        }
    }
    
    func getActionSheet() -> ActionSheet {
        
        switch self.actionSheetType {
        case .general:
            return ActionSheet(title: Text("What would you like to do"), message: nil, buttons: [
                .destructive(Text("Report"), action: {
                    
                    self.actionSheetType = .reporting
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.showActionSheet.toggle()
                    }
                    
                }),
                
                .default(Text("Learn more..."), action: {
                    print("LEARN MORE PRESSED")
                }),
                
                .cancel()
            
            ])
        case .reporting:
            return ActionSheet(title: Text("Why are you reporting this post?"), message: nil, buttons: [
            
                .destructive(Text("This is inappropriate"),action: {
                    reportPost(reason: "This is inappropriate")
                }),
                .destructive(Text("This is spam"),action: {
                    reportPost(reason: "This is spam")
                }),
                .destructive(Text("It made me uncomfortable"),action: {
                    reportPost(reason: "It made me uncomfortable")
                }),
                
                .cancel({
                    self.actionSheetType = .general
                })
            ])
        }
    }
    
    func reportPost(reason: String) {
        print("REPORT POST NOW")
        
        DataService.instance.uploadReport(reason: reason, postID: post.postID) { (succcess) in
            if succcess {
                self.alertTitle = "Reported"
                self.alertMessage = "Thanks for reporting this post. We will review it shortly and take the appropriate action!"
                self.showAlert.toggle()
            } else {
                self.alertTitle = "Error"
                self.alertMessage = "There was an error uploading the report. Please restart the app and try again"
                self.showAlert.toggle()
            }
        }
    }
    
    func sharePost() {
        
        let message = "Check this post on CatGram"
        let image = postImage
        let link = URL(string: "https://www.google.com")!
        
        let activiyViewController = UIActivityViewController(activityItems: [message, image, link], applicationActivities: nil)
        
        let viewController = UIApplication.shared.windows.first?.rootViewController
        viewController?.present(activiyViewController, animated: true, completion: nil)
    }
}

struct PostView_Previews: PreviewProvider {
    
    static var post: PostModel = PostModel(postID: "", userID: "", username: "Wentao Wu", caption: "This is a test caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
    
    static var previews: some View {
        PostView(post: post, showHeaderAndFooter: true, addheartAnimationToView: true)
            .previewLayout(.sizeThatFits)
    }
}
