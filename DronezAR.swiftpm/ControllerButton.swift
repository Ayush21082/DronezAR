//
//  ControllerButton.swift
//  DroneARApp
//
//  Created by Ayush Singh on 19/04/23.
//

import SwiftUI

import SwiftUI

struct ControllerButton: View {
    var image: String = "rotate"
    var action: () -> Void
    var isVisible: Bool = true
    var bgcolor: Color = Color.white
    var body: some View {
        
        VStack {
            if isVisible {
                Button(action: {
                    action()
                }) {
                    Image(image)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                }
                .padding()
                .background(bgcolor)
                .clipShape(Circle())
                .frame(width: 70, height: 70)
            }
        }.padding()
    }
}
