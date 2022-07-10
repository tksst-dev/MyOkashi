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
    // SafariViewの表示有無を管理する変数
    @State var showSafari = false
    
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
            
            // リスト表示する
            List(okashiDataList.okashiList) { okashi in
                // １つ１つの要素が取り出される
                
                // ボタンを用意する
                Button(action: {
                    // SafariViewを表示する
                    showSafari.toggle()
                }) {
                    // Listの表示内容を生成する
                    // 水平にレイアウト（横方向にレイアウト）
                    HStack {
                        // 画像を読み込み、表示する
                        AsyncImage(url: okashi.image) { image in
                            // 画像を表示する
                            image
                                // リサイズ
                                .resizable()
                                // アスペクト比（縦横比）を維持してエリア内に収まるようにする
                                .aspectRatio(contentMode: .fit)
                                // 高さ40
                                .frame(height: 40)
                        } placeholder: {
                            // 読み込み中はインジケータを表示する
                            ProgressView()
                        }
                        // テキスト表示する
                        Text(okashi.name)
                    } // HStack終了
                } // Button終了
                .sheet(isPresented: self.$showSafari, content: {
                    // SafariViewを表示する
                    SafariView(url: okashi.link)
                        // 画面下部がセーフエリア外までいっぱいになるように指定
                        .edgesIgnoringSafeArea(.bottom)
                }) // sheet終了
            } // List終了
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
