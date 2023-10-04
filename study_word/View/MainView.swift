//
//  MainView.swift
//  study_word
//
//  Created by ByteDance on 2023/10/2.
//

import SwiftUI

struct MainView: View {
    @StateObject var menu = MenuBarExtraManager.shared()
    @State private var withTimeIntervalSecond = ""
    var body: some View {
//        if #available(macOS 13.0, *) {
//            NavigationSplitView{
//                SideBarView()
//            } detail: {
//                Text("查看主界面")
//            }
//        } else {
        NavigationView{
            SideBarView()
            Text("瞟一眼记单词，积少成多，每天记10个，一年也有3650个。").foregroundColor(.green).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        }.toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigation) {
                Button {
                    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                } label: {
                    Label("Sidebar", systemImage: "sidebar.left")
                }
            }
            // 添加搜索框到工具栏
            ToolbarItem(placement: .automatic) {
                HStack(spacing: 16) {
                    // 搜索框
                    TextField("设置单词闪烁时间，当前间隔时间\(menu.withTimeIntervalSecond)S",text:$withTimeIntervalSecond).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        print(Int(withTimeIntervalSecond))
                        menu.withTimeIntervalSecond = Int(withTimeIntervalSecond) ?? 1
                        menu.start()
                    }) {
//                        Image(systemName: "magnifyingglass")
                        Text("确定")
                    }.frame(minWidth: 50)
                }
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

