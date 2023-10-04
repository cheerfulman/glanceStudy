//
//  LoginView.swift
//  study_word
//
//  Created by ByteDance on 2023/10/2.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var store:Store
    
    @State private var username = ""
    @State private var password = ""
    var body: some View {
        Text("欢迎登陆")
        Form {
            TextField("用户名", text: $username)
            SecureField("密码", text: $password)
            Button {
                print(username)
                print("密码 \(password)")
                store.loggedIn = true
            } label: {
                Text("登陆")
            }
        }.padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
