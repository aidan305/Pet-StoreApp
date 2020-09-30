//
//  SignInView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 17/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(named: "Primary Green") ?? Color.purple] //changing the color of the navigation bar title
    }
    
    func signIn() {
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
        print("sign user in !!")
    }
    
    var body: some View {
        VStack {
            Image("Paw")

            VStack(spacing: 15) {
                TextField("Email address", text: $email)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.blue, lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.blue, lineWidth: 1))
            }
            .padding(.bottom, 60)
            .padding(.vertical, 55)
            VStack(spacing: 30){
                Button(action: signIn) {
                    Text("Log In")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(LinearGradient(gradient: Gradient(colors: [Color("Primary Green"), Color("Primary Green")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(5)
                }
            }
            Spacer()
            if (error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding(.bottom, 140)
        .padding(.horizontal, 32)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
