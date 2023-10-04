//
//  Conversation.swift
//  study_word
//
//  Created by ByteDance on 2023/10/2.
//

import Foundation


// Identifiable 需要集成该类，确定便利的ID
class Conversation:Identifiable {
    var id: Int
    var avatar: String
    var title: String
    var wordBookName: String
    
    init(id:Int, avatar: String, title: String, wordBookName: String) {
        self.id = id
        self.avatar = avatar
        self.title = title
        self.wordBookName = wordBookName
    }
    
}
