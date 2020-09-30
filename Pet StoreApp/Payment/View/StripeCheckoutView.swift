//
//  StripeCheckoutView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 04/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct StripeCheckoutView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) ->  UIViewController {
        let storyboard = UIStoryboard(name: "CustomCheckout", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Checkout") as StripeCheckoutViewController
        return controller
    }
    
    func updateUIViewController(_ uiViewController:  UIViewController, context: Context) {
     
    }
}

