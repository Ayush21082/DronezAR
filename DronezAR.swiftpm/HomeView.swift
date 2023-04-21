//
//  ContentView.swift
//  Introduction
//
//  Created by Ayush Singh on 19/04/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                ZStack{}
                    .frame( maxWidth: .infinity, maxHeight: .infinity)
                    .background(Image("bg").resizable())
                    .ignoresSafeArea()
                VStack {
                    Image("profile")
                        .resizable()
                        .frame(width: 300, height: 300)
                    Text("Hii! 👋🏻 I'am Ayush Singh")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                    Text("I'm an astute App, Web Developer, and Designer with a passion for ideation, design, and creation of innovative products. I'm also an Apple  WWDC 2021 & 2022 Swift Student Challenge winner")
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 60)
                        .padding(.vertical)
                        .foregroundColor(.gray)
                    
                    HStack{
                        NavigationLink(destination: UserManual()) {
                            
                                HStack {
                                    Image(systemName: "eyeglasses")
                                        .foregroundColor(.black)
                                    Text("Watch my WWDC23 Project")
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                }
                                .padding()
                                .background(.white)
                                .cornerRadius(30)
                                
                            
                        }
                        
                    }

                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserManual()
    }
}




struct Demo: View {

    let fileUrl = Bundle.main.url(forResource: "demo1", withExtension: "mp4")!
    
    var body: some View {
        VStack {
            HStack{
//                VideoPlayer(player: AVPlayer(url:  URL(string: "https://bit.ly/swswift")!))
//                VideoPlayer(player: AVPlayer(url: fileUrl))
            }
        }
    }
}
