//
//  MenuBar.swift
//  study_word
//
//  Created by ByteDance on 2023/10/4.
//

import SwiftUI

struct MenuBar: View {
    @StateObject var menu = MenuBarExtraManager.shared()
    @State private var withTimeIntervalSecond = ""
    @State private var isValidInput: Bool = true
    var body: some View {
        VStack {
            Image(systemName: "teddybear.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("\(menu.word) \(menu.translation)").font(.caption)
                .padding()
            
            TextField("设置单词闪烁时间，当前间隔时间\(menu.withTimeIntervalSecond)S",text:$withTimeIntervalSecond).textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: withTimeIntervalSecond) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        withTimeIntervalSecond = filtered
                    }
                }
            
            if !isValidInput {
                Text("请输入有效的整数").foregroundColor(.red)
            }
            
            Button(action: {
                if let intervalTimeInt = Int(withTimeIntervalSecond) {
                    print(intervalTimeInt)
                    menu.withTimeIntervalSecond = Int(withTimeIntervalSecond) ?? 1
                    menu.start()
                    withTimeIntervalSecond = ""
                } else {
                    // 处理输入无效的情况
                    isValidInput = false
                }
            }) {
                Text("确定")
            }.frame(minWidth: 50)
            
            
            
            Divider()

            HStack {
                Spacer()
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }.keyboardShortcut("q")
            }
        }
        .padding()
    }
}

#Preview {
    MenuBar()
}
