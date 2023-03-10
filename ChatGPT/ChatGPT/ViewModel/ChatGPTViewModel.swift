//
//  ChatGPTViewModel.swift
//  ChatGPT
//
//  Created by Fernando Matheus Ferreira Adomaitis Bruno on 09/03/23.
//

import Foundation
import OpenAISwift

class ChatGPTViewModel: ObservableObject {
    @Published var chatModel: [Chat] = []
    
    init() {
        addMessage(text: "")
    }
    
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String) {
        addMessage(text: text)
        client?.sendCompletion(with: text, maxTokens: 100) { result in
            switch result {
            case .success(let success):
                print(success.choices.first?.text ?? "")
                self.addMessage(text: success.choices.first?.text ?? "")
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func addMessage(text: String) {
        let messages = [Chat(messages: text)]
        chatModel = messages
    }
}
