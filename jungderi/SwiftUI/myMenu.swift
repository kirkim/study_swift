//
//  ContentView.swift
//  Mymenu
//
//  Created by κΉκΈ°λ¦Ό on 2021/12/29.
//

import SwiftUI

struct ContentView: View {
    
    let animalDatas: [String] = ["πΆ λλ κ°μμ§!", "π± λλ κ³ μμ΄!", "π΅ λλ μμ­μ΄!"]
    @State private var popAlert: Bool = false
    @State private var stateMessage: String = ""
    @State private var selectedAnimal: String
    
    init () {
        selectedAnimal = self.animalDatas[0]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text(self.selectedAnimal)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                Spacer()
                Spacer()
            } // VStack
            .navigationTitle("νμ΄μ")
            .toolbar {
                Menu(content: {
                    Section(content: {
                        Button(action: {
                            self.popAlert = true
                            self.stateMessage = "μ€λλ νκΈ°μ°¨κ²!"
                        }, label: {
                            Text("μ€λλ νκΈ°μ°¨κ²!")
                        })
                        Button(action: {
                            self.popAlert = true
                            self.stateMessage = "μ€λλ λΉ‘μ½λ©!"
                        }, label: {
                            Text("μ€λλ λΉ‘μ½λ©!")
                        })
                    }, header: {
                        Text("μν νμ")
                    })
                       
                    Section(content: {
                        Picker("λλ¬Όμ ν", selection: $selectedAnimal, content: {
                            ForEach(self.animalDatas, id: \.self, content: { data in
                                Text(data).tag(data)
                            })
                        })
                    }, header: {
                        Text("λλ¬Ό μ ν")
                    })
                }, label: {
                    Circle()
                        .frame(width: 50, height: 50, alignment: .center)
                        .overlay(
                            Image(systemName: "ellipsis")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                        )
                })
            } // toolbar
            .alert("State", isPresented: $popAlert, actions: {
            }, message: {
                Text(self.stateMessage)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
