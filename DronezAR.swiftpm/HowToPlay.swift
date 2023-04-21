//
//  HowToPlay.swift
//  Introduction
//
//  Created by Ayush Singh on 19/04/23.
//

import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        ZStack {
            ZStack{}
                .frame( maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("bg").resizable())
                .ignoresSafeArea()
                .navigationTitle("How to use")
                
            TabView {
                OnboardingStepView(image: "step2", title: "Power On", description: "To power on the drone, press the Power On button on the app. Once the drone is turned on, its indicator lights will turn to green.")
                OnboardingStepView(image: "step1", title: "Left Joystick", description: "Use the left joystick to control the drone's altitude and rotation. Push the joystick up to make the drone ascend, and push it down to make it descend. You can also rotate the drone by moving the joystick left or right.")
                OnboardingStepView(image: "step5", title: "Right Joystick", description: "Use the right joystick to control the drone's movement. Push the joystick forward to make the drone move forward, and pull it back to make it move backward. You can also move the drone left or right by moving the joystick left or right.")
                OnboardingStepView(image: "step4", title: "Back To Position", description: "If you need to pause the drone's movement and go back to its original location, press the Pause button on the app. The drone will automatically return to its takeoff point.")
                OnboardingStepView(image: "step3", title: "Action", description: "If you want the drone to perform some entertaining rotations, press the Action button on the app. The drone will start performing a pre-programmed rotation, such as a barrel roll or a flip.")
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

struct OnboardingStepView: View {
    var image: String
    var title: String
    var description: String

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack {
                VStack {
                    VStack(spacing: 20) {
                        Text(title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)

                        
                        Text(description)
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        
                    }
                    .padding()
                    .background(.white).cornerRadius(10)
                    Spacer()
                }
                
              
            }
            .padding()
            
            
        }
    }
}
