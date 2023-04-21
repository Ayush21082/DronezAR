//
//  UserManual.swift
//  Introduction
//
//  Created by Ayush Singh on 19/04/23.
//

import SwiftUI

struct UserManual: View {
    var body: some View {
        ZStack {
            Color.white
            ZStack{}
                .frame( maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("bg").resizable())
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                HStack {
                    Image("DronezAR")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                }.padding()
                Image("drone")
                    .resizable()
                    .frame(width: 400, height: 250)
                NavigationLink(destination: HowToPlayView()) {
                    
                    
                    HStack {
                        Text("How to use")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(width: 300)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    
                    
                }
                
                NavigationLink(destination: DroneARView()) {
                    
                    HStack {
                        Text("Go Fly")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(width: 300)
                    .background(.white)
                    .cornerRadius(30)
                    
                    
                    
                }
                NavigationLink(destination: DemoVideo()) {
                    HStack {
                        Text("Watch Demo")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .underline()
                    }
                }
                
            }
            
        }
    }
}
