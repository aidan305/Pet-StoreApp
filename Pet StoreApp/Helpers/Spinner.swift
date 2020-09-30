//
//  Spinner.swift
//  LittleBudsUploadApp
//
//  Created by aidan egan on 25/06/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct Spinner: View {
    
    @State var spinner = false
    @State private var animateCircle = false
    var body: some View {
        
        VStack{
            Text("Uploading please wait....")
                .foregroundColor(Color("LBPurple"))
                .font(.system(size: 30))
            Image(systemName: "arrow.2.circlepath.circle.fill")
                .resizable()
                .frame(width: 128, height: 128)
                .foregroundColor(Color("LBPurple"))
                .rotationEffect(.degrees(animateCircle ? 360 : 0))
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
                .onAppear{
                    self.animateCircle.toggle()
            }
            .onAppear {
                self.spinner.toggle()
            }
        }
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}

