//
//  study_wordApp.swift
//  study_word
//
//  Created by ByteDance on 2023/10/2.
//

import SwiftUI

@main
struct study_wordApp: App {
    
    @StateObject var store = Store()
    @StateObject var menu = MenuBarExtraManager.shared()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
        
        MenuBarExtra(content: {
//            ContentView().environmentObject(Store()).environmentObject(menu)
            MenuBar().environmentObject(menu)
            
        }, label: {
            Text("\(menu.word), \(menu.phonetic) \(menu.translation)")
        })
        .menuBarExtraStyle(.window)
        
    }
}

