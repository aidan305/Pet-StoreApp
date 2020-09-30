//
//  SessionStore.swift
//  Pet StoreApp
//
//  Created by aidan egan on 17/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

//IMPORTANT global varibale look at better option here. workaround for repoProductDownload to access userid on start up to check if product is favourite on inital load
var globalUserID : String?

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? {didSet {self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    var newSignUp: Bool = false
    var name = ""
    let repo = RepositoryUser()

    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                if self.newSignUp == true {
                    globalUserID = user.uid
                    self.session = User(uid: user.uid, email: user.email, name: self.name, newUser: true)
                    self.repo.registerUserIntoDatabase(id: user.uid ,email: user.email!, name: self.name) {
                        print("user registered to firebase database!")
                    }
                    
                } else {
                    globalUserID = user.uid
                    self.session = User(uid: user.uid, email: user.email, name: nil, newUser: false)
                }
            } else {
                self.session = nil
            }
        })
    }
    
    func signUp(email: String, password: String, name: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
        newSignUp = true
        self.name = name
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            print("Error signing out")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}


