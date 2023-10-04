//
//  SideBarView.swift
//  study_word
//
//  Created by ByteDance on 2023/10/2.
//

import SwiftUI
import Combine
enum SidebarItem: String, CaseIterable {
    case conversations
    case settings
    // 添加更多侧边栏选项，如果需要的话
}

struct SideBarView: View {
    @StateObject var menu = MenuBarExtraManager.shared()
    @EnvironmentObject var store: Store
    @State private var selectedConversation: Conversation? = nil
    var body: some View {
        Section() {
            List(store.conversations) {
                conversation in
                NavigationLink(conversation.title, destination: SPList(bookName: conversation.wordBookName, title:conversation.title))
            }
        }
    }
}


struct SPList: View {
    var bookName: String
    var title: String
    @StateObject var menu = MenuBarExtraManager.shared()
    
    @State private var withTimeIntervalSecond = ""

    init(bookName: String, title: String) {
        self.bookName = bookName
        self.title = title
    }
    
    var body: some View {
        Text("\(menu.word) \(menu.translation)")
        Form {
            // 整数输入框
//            TextField("设置单词闪烁时间", text: $withTimeIntervalSecond)
            Button {
                print(self.bookName)
                MenuBarExtraManager.resourcePath = bookName
                print(MenuBarExtraManager.resourcePath)
                menu.readWordsFromText()
            } label: {
                Text("选择当前单词书")
            }
        }.padding()
        .navigationTitle(title)
//        .searchable(text: $searchText)
    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView()
    }
}
