//
//  store.swift
//  study_word
//
//  Created by ByteDance on 2023/10/2.
//

import Foundation
import AppKit

class Store: ObservableObject {
    @Published var loggedIn = true
    
    @Published var conversations: [Conversation] = [
        Conversation(id: 1, avatar: "11", title: "四级乱序", wordBookName: "CET-4"),
        Conversation(id: 2, avatar: "22", title: "四级正序", wordBookName: "CET-zheng")
    ]
}
