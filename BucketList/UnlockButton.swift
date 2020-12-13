//
//  UnlockButton.swift
//  BucketList
//
//  Created by Juliette Rapala on 12/12/20.
//

import SwiftUI
import LocalAuthentication

struct UnlockButton: View {
    @Binding var isUnlocked: Bool
    
    var body: some View {
        Button("Unlock Places") {
            self.authenticate()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // string is for TouchID
            // FaceID uses plist
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct UnlockButton_Previews: PreviewProvider {
    static var previews: some View {
        UnlockButton(isUnlocked: .constant(false))
    }
}
