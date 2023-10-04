//
//  ContentView.swift
//  study_word
//
//  Created by ByteDance on 2023/10/2.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        if store.loggedIn {
            MainView()
        } else {
            LoginView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store())
    }
}
