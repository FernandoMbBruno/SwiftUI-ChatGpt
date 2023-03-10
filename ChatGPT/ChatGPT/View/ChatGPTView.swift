//
//  ChatGPTView.swift
//  ChatGPT
//
//  Created by Fernando Matheus Ferreira Adomaitis Bruno on 09/03/23.
//

import SwiftUI

struct ChatGPTView: View {
    @ObservedObject var viewModel = ChatGPTViewModel()
    @State var text = ""
    var body: some View {
        VStack {
            VStack {
                ForEach(viewModel.chatModel, id: \.self) { response in
                    Text(response.messages)
                }
            }.onAppear {
                viewModel.setup()
            }
            
            Spacer()
            
            HStack {
                TextField("Write Something", text: $text)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                Button {
                    viewModel.send(text: text)
                    text = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                .font(.system(size: 23))
                .padding(.horizontal, 5)
            }
            .padding()
        }
    }
}

struct ChatGPTView_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPTView()
    }
}
