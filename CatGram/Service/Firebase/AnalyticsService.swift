//
//  AnalyticsService.swift
//  CatGram
//
//  Created by Wentao on 1/20/21.
//

import Foundation
import FirebaseAnalytics

class AnalyticsService {
    
    static let instance = AnalyticsService()
    
    func likePostDoubleTap() {
        Analytics.logEvent("like_doulbe_tap", parameters: nil)
    }
    
    func likePostHeartPressed() {
        Analytics.logEvent("like_heart_clicked", parameters: nil)
    }
    
}
