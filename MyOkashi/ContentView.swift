//
//  ContentView.swift
//  MyOkashi
//
//  Created by 習田武志 on 2022/07/09.
//

import SwiftUI

struct ContentView: View {
    // OkashiDataを参照する状態変数
    @StateObject var okashiDataList = OkashiData()
    // 入力された文字列を保持する状態変数
    @State var inputText = ""
    
    var body: some View {
        // 垂直にレイアウト（縦方向にレイアウト）
        VStack {
            // 文字を受け取るTextFieldを表示する
            TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください"))
                .onSubmit {
                    Task {
                        await okashiDataList.searchOkashi(keyword: inputText)
                    }
                }
                .submitLabel(.search)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
