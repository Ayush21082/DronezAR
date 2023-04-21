import SwiftUI
import RealityKit
import ARKit
import SceneKit

struct DroneARView : View {
    
    @State var arView = ARView(frame: .zero)
    @State var droneEntity: Entity?
    @State var droneAnchor: Experience.DronePro?
    //JoyStick 1
    @State private var xTranslation: CGFloat = 0.0
    @State private var yTranslation: CGFloat = 0.0
    //Joystick 2
    @State private var aTranslation: CGFloat = 0.0
    @State private var bTranslation: CGFloat = 0.0
    
    @State var isPowerOn: Bool = false
    
    var body: some View {
        ZStack {
            ARViewContainer(arView: $arView).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                //Controllers
                HStack {
                    VStack {
                        Spacer()
                        //Power Button
                        ControllerButton(image: "power", action: {
                            powerCheck()
                        }, bgcolor: isPowerOn ? .green : .red)
                    }
                    Spacer()
                    VStack {
                        Spacer()
                        //Drone to position
                        ControllerButton(image: "pause", action: {
                            droneToPosition()
                        })
                        //Perform Action
                        ControllerButton(image: "rotate") {
                            performActionPitch()
                        }
                    }
                    

                    
                }.padding()
                //JoySticks
                HStack {
                    //Joystick 1
                    JoystickView()
                        .onTranslation({ secondTranslation in
                            guard let secondTranslation = secondTranslation else {
                                self.aTranslation = 0.0
                                self.bTranslation = 0.0
                                return
                            }
                            self.aTranslation = secondTranslation.x
                            self.bTranslation = secondTranslation.y
                        })
                        .frame(maxWidth: 200, maxHeight: 200)
                    
                    Text(getDirection())

                    Spacer()
                    
                    //Joystick 2
                    Text(getAngle()).foregroundColor(.white)
                    
                    JoystickView()
                        .onTranslation({ translation in
                            guard let translation = translation else {
                                self.xTranslation = 0.0
                                self.yTranslation = 0.0
                                return
                            }
                            self.xTranslation = translation.x
                            self.yTranslation = translation.y
                        })
                        .frame(maxWidth: 200, maxHeight: 200)
                    
                }
            }.padding()
            HStack {
                Spacer()
                VStack {
                    NavigationLink(destination: HowToPlayView()) {
                        Image(systemName: "info.circle.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .padding()
                    }
                    Spacer()
                }
            }
 

        }
        .onAppear {
            loadDroneEntity()
        }
    }
    
    func getDirection() -> String {
        
        if isPowerOn {
            if abs(xTranslation) > abs(yTranslation) {
                if xTranslation > 0 {
                    moveDroneRight()
                    return ""
                } else if xTranslation < 0 {
                    moveDroneLeft()
                    return ""
                } else {
                    return ""
                }
            } else {
                if yTranslation > 0 {
                    moveDroneBackward()
                    return ""
                } else if yTranslation < 0 {
                    moveDroneForward()
                    return ""
                } else {
                    
                }
            }
        }
        return ""
    }
    
    func getAngle() -> String {
        if isPowerOn {
            if abs(aTranslation) > abs(bTranslation) {
                if aTranslation > 0 {
                    rotateDroneRight()
                    return ""
                } else if aTranslation < 0 {
                    rotateDroneLeft()
                    return ""
                } else {
                    return ""
                }
            } else {
                if bTranslation > 0 {
                    moveDroneDown()
                    return ""
                } else if bTranslation < 0 {
                    moveDroneUp()
                    return ""
                } else {
                    return ""
                }
            }
        }
        return ""
    }
    
    private func loadDroneEntity() {
        do {
            let droneScene = try Experience.loadDronePro()
            droneEntity = droneScene.findEntity(named: "DronePro")
            droneAnchor = droneScene
            if let entity = droneEntity {
                arView.installGestures(.all, for: entity as! HasCollision)
                entity.generateCollisionShapes(recursive: true)
                arView.scene.addAnchor(droneScene)
                arView.addCoaching()
            }
        } catch {
            print("Error loading drone entity: \(error.localizedDescription)")
        }
    }
    
    private func powerCheck() {
        isPowerOn.toggle()
        if isPowerOn {
            guard let droneAnchor = droneAnchor else {
                print("Error: droneAnchor is nil")
                return
                
            }
            droneAnchor.notifications.droneUp.post()
        }else{
            droneToPosition()
            droneAnchor?.dronePro?.stopAllAudio()
            droneAnchor?.notifications.droneOff.post()
        }
    }
    
    private func moveDroneUp() {
        
        guard let drone = droneEntity else { return }
        let animationDuration = 1.0
        var transform = drone.transform
        transform.translation += SIMD3(x: 0, y: 0.3, z: 0)
        drone.move(to: transform, relativeTo: drone.parent, duration: animationDuration)
        
    }
    
    private func moveDroneDown() {
        
        let floor:SIMD3<Float> = SIMD3(x: 0, y: 0, z: 0)
        guard let drone = droneEntity else { return }
        let animationDuration = 1.0
        var transform = drone.transform
        transform.translation += SIMD3(x: 0, y: -0.3, z: 0)
        if floor.y >= transform.translation.y {
            // Do something if the drone has reached the floor
        }
        drone.move(to: transform, relativeTo: drone.parent, duration: animationDuration)
        
    }
    
    private func moveDroneLeft() {
        guard let droneAnchor = droneAnchor else {
            print("Error: droneAnchor is nil")
            return
            
        }
        droneAnchor.notifications.droneLeft.post()
    }
    
    private func moveDroneRight() {
        guard let droneAnchor = droneAnchor else {
            print("Error: droneAnchor is nil")
            return
            
        }
        droneAnchor.notifications.droneRight.post()
    }
    
    private func moveDroneForward() {
        guard let droneAnchor = droneAnchor else {
            print("Error: droneAnchor is nil")
            return
            
        }
        droneAnchor.notifications.droneForward.post()
    }
    
    private func moveDroneBackward() {
        guard let droneAnchor = droneAnchor else {
            print("Error: droneAnchor is nil")
            return
            
        }
        droneAnchor.notifications.droneBackward.post()
        
    }
    
    private func droneToPosition() {
        guard let drone = droneEntity else { return }
        let animationDuration = 4.0
        var transform = drone.transform
        transform.translation = SIMD3(x: 0, y: 0, z: 0)
        drone.move(to: transform, relativeTo: drone.parent, duration: animationDuration)
    }
    
    private func rotateDroneLeft() {
        guard let droneAnchor = droneAnchor else {
            print("Error: droneAnchor is nil")
            return
            
        }
        droneAnchor.notifications.droneRotateLeft.post()
    }
    
    private func rotateDroneRight() {
        guard let droneAnchor = droneAnchor else {
            print("Error: droneAnchor is nil")
            return
            
        }
        droneAnchor.notifications.droneRotateRight.post()
    }
    
    private func performActionPitch() {
        guard let droneAnchor = droneAnchor else {
            print("Error: droneAnchor is nil")
            return
            
        }
        droneAnchor.notifications.performActionOne.post()
    }
    
    
    
}


struct ARViewContainer: UIViewRepresentable {
    @Binding var arView: ARView
    
    
    func makeUIView(context: Context) -> ARView {
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    
    
    
}

extension ARView: ARCoachingOverlayViewDelegate {
    func addCoaching() {
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = self.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        coachingOverlay.goal = .anyPlane
        self.addSubview(coachingOverlay)
        
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        //Ready to add entities next?
    }
}


