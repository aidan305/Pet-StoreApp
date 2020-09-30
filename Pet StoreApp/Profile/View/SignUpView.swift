//
//  SignUpView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 17/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var error: String = ""
    @Binding var tabSelection: Int
    @ObservedObject private var keyboard = KeyboardResponder()
    @EnvironmentObject var session: SessionStore
    
    func signUp() {
        
        if self.name != "" {
            if email != "" {
                if password == confirmPassword && password != "" {
                    error = ""
                    session.signUp(email: email, password: password, name: name) { (result, error) in
                        if let error = error {
                            self.error = error.localizedDescription
                        } else {
                            self.email = ""
                            self.password = ""
                            self.confirmPassword = ""
                            self.error = "Account Created"
                        }
                    }
                }
                else{
                    error = "Passwords do not match or are missing"
                }
            }
            else {
                error = "The email is missing"
            }
        }else {
            error = "Name is missing"
        }
    }
    
    
    var body: some View {
        NavigationView{
            VStack {
                if keyboard.currentHeight == 0 {
                    Image("DOG WITH SUNGLASSES").resizable()
                    Spacer()
                    
                }
                VStack(spacing: 7) {
                    TextField("Name", text: $name)
                        .font(.system(size: 14))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("Primary Green"), lineWidth: 1))
                        .accessibility(identifier: "SignUpName")
                    
                    TextField("Email address", text: $email)
                        .font(.system(size: 14))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("Primary Green"), lineWidth: 1))
                        .accessibility(identifier: "SignUpEmail")
                    
                    SecureField("Password", text: $password)
                        .font(.system(size: 14))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("Primary Green"), lineWidth: 1))
                        .accessibility(identifier: "SignUpPassword")
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .font(.system(size: 14))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("Primary Green"), lineWidth: 1))
                        .accessibility(identifier: "SignUpConfirmPassword")
                }.padding(.bottom, keyboard.currentHeight - 19)
                
                Button(action: signUp) {
                    Text("Create Account")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 45)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(LinearGradient(gradient: Gradient(colors: [Color("Primary Green"), Color("Primary Green")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(5)
                        .shadow(radius: 10)
                        .accessibility(identifier: "SignUpButton")
                }.padding(.top, 30)
                
                Spacer()
                
                NavigationLink(destination: SignInView()) {
                    HStack {
                        Text("I already have an account")
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(.primary)
                        
                        Text("Sign In")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color("Primary Green"))
                    }
                }
                if (error != "") {
                    Text(error)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.red)
                        .padding()
                }
                Spacer()
            }
            .modifier(CustomNavigationBarViewModifier(sectionTitle: "Sign Up", spacing: 95, tabSelection: $tabSelection))
            .padding(.horizontal, 32)
        }
    }
}

