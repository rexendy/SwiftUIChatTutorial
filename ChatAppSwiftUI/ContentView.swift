//
//  ContentView.swift
//  ChatAppSwiftUI
//
//  Created by rexen dy  on 1/26/21.
//  Copyright © 2021 rexen dy . All rights reserved.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        Text("Hello, World!")
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

// create a struct that will represent each message in chat
struct ChatMessage : Hashable {
    var message: String
    var avatar: String
    var color: Color
    var isMe: Bool = false
}

struct ContentView: View {
     @State var composedMessage: String = ""
    @EnvironmentObject var chatController: ChatController

    var body: some View {
        VStack {
            List {
                       ForEach(chatController.messages, id: \.self) { msg in
                           ChatRow(chatMessage: msg)
                       }
                   }

            HStack {
                TextField("Message...", text: $composedMessage).frame(minHeight: CGFloat(30))
                Button(action: sendMessage) {
                    Text("Send")
                }
            }
        }
    }

    func sendMessage() {
        chatController.sendMessage(ChatMessage(message: composedMessage, avatar: "C", color: .green, isMe: true))
        composedMessage = ""
    }
}

struct ChatRow: View {
    var chatMessage: ChatMessage

    var body: some View {
        Group {
            if !chatMessage.isMe {
                HStack {
                    Group {
                        Text(chatMessage.avatar)
                        Text(chatMessage.message)
                            .bold()
                            .foregroundColor(.white)
                            .padding(10)
                            .background(chatMessage.color)
                            .cornerRadius(10)
                    }
                }
            } else {
                HStack {
                    Group {
                        Spacer()
                        Text(chatMessage.message)
                            .bold()
                            .foregroundColor(.white)
                            .padding(10)
                            .background(chatMessage.color)
                                .cornerRadius(10)
                        Text(chatMessage.avatar)

                    }
                }
            }
        }

    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(ChatController())
    }
}
#endif
