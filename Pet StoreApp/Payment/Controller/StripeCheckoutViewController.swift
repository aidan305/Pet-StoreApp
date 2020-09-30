//
//  StripeCheckoutViewController.swift
//  Pet StoreApp
//
//  Created by aidan egan on 04/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import UIKit
import Stripe
import Alamofire
import SwiftUI


class StripeCheckoutViewController: UIViewController, STPAuthenticationContext {
    //MARK: UI CODE
    
    @ObservedObject var cart = CartStore()
    @IBOutlet weak var paymentStackView: UIStackView!
    var shippingRowStackView = UIStackView()
    var totalCostRowStackView = UIStackView()
    var customerNameTextField = UITextField()
    var paymentBtn = UIButton()
    var stripepaymentCardTextField = STPPaymentCardTextField()
    let apiClient = PaymentAPIClient()
    var paymentContext = STPPaymentContext()
    let config = STPPaymentConfiguration.shared()
    static var confirmationScreenVC = UIViewController()
    let orderID = Utils().generateOrderNumber()
    var customerEmailFromShippingForm = ""
    var customerName = "Pet Store Customer"
    //let cartView = CartView()
    let loadingViewController = LoadingViewController()
    let addShippingBtn = UIButton()
        
    static var totalCostLabel = UILabel()
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        initialSetup() //set up payment and customer contexts 
    }
    
    
    func setupUI(){
        setupShippingRow()
        setUpTotalCostRow()
        setupNameTextField()
        setUpPayButton()
        
        let paymentLabel = getPaymentSectionTitle()
    
        //paymentStackView.spacing = 30
        
        paymentStackView.alignment = .center
        paymentStackView.addArrangedSubview(shippingRowStackView)
        paymentStackView.setCustomSpacing(10, after: shippingRowStackView)
        paymentStackView.addArrangedSubview(paymentLabel)
        setupDivderLines() //adds divider line above and below shipping row
        paymentStackView.setCustomSpacing(8, after: paymentLabel)
        paymentStackView.addArrangedSubview(customerNameTextField)
        paymentStackView.setCustomSpacing(5, after: customerNameTextField)
        paymentStackView.addArrangedSubview(setUpStripeCardInputView())
        paymentStackView.setCustomSpacing(5, after: stripepaymentCardTextField)
        paymentStackView.setCustomSpacing(5, after: customerNameTextField)
        paymentStackView.addArrangedSubview(totalCostRowStackView)
        paymentStackView.addArrangedSubview(paymentBtn)       
    }
    
    func dismissConfirmationModuleScreen(){
        self.dismiss(animated: false) {
            
        }
    }
    
    func setUpStripeCardInputView() -> STPPaymentCardTextField {
        stripepaymentCardTextField.widthAnchor.constraint(equalToConstant: screenWidth/1.1).isActive = true
        stripepaymentCardTextField.accessibilityLabel = "Stripe Payment Card View"
        stripepaymentCardTextField.accessibilityIdentifier = "Stripe Payment Card View"
        
        return stripepaymentCardTextField
    }
    
    func setupShippingRow(){
        let titleLabel = UILabel()
        addShippingBtn.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        addShippingBtn.setTitle("Select address", for: .normal)
        addShippingBtn.setTitleColor(.black, for: .normal)
        addShippingBtn.addTarget(self, action: #selector(addShippingAddressPressed), for: .touchUpInside)
        titleLabel.text = "Ship to:"
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = .left;
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.isAccessibilityElement = false
        
        shippingRowStackView.widthAnchor.constraint(equalToConstant: screenWidth/1.1).isActive = true
        
        shippingRowStackView.addArrangedSubview(titleLabel)
        shippingRowStackView.addArrangedSubview(addShippingBtn)
    }
    
    func setUpTotalCostRow(){
        let titleLabel = UILabel()
        var totalPriceToDisplay = ""
        totalPriceToDisplay = String(format: "%.2f", cart.calculateTotalCost()) //2 decimal places
        totalCostRowStackView.axis = .horizontal
        totalCostRowStackView.alignment = .leading
        totalCostRowStackView.distribution = .equalSpacing
        
        titleLabel.text = "Total:"
        StripeCheckoutViewController.loadTotalPriceToScreen(priceString: totalPriceToDisplay)
        
        
        totalCostRowStackView.addArrangedSubview(titleLabel)
        totalCostRowStackView.addArrangedSubview(StripeCheckoutViewController.totalCostLabel)
        totalCostRowStackView.widthAnchor.constraint(equalToConstant: screenWidth/1.1).isActive = true
    }
    
    static func loadTotalPriceToScreen(priceString: String){
         totalCostLabel.text = "€\(priceString)"
    }
    
    
    func setUpPayButton(){
        paymentBtn.layer.borderWidth = 4
        paymentBtn.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        paymentBtn.layer.cornerRadius = 10
        paymentBtn.setTitle("Submit payment", for: .normal)
        paymentBtn.backgroundColor = UIColor(named: "Primary Green")
        paymentBtn.setTitleColor(.white, for: .normal)
        paymentBtn.addTarget(self, action: #selector(payButtonPressed), for: .touchUpInside)
        
        paymentBtn.widthAnchor.constraint(equalToConstant: screenWidth/2).isActive = true
         
    }
    
    func setupNameTextField(){
        customerNameTextField.attributedPlaceholder = NSAttributedString(string: "CardHolder Name", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 18.0)
        ])
        customerNameTextField.layer.borderWidth = 1
        //hack to add padding to text field
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        customerNameTextField.leftView = paddingView
        customerNameTextField.leftViewMode = .always
        customerNameTextField.frame.size.height = 45
        customerNameTextField.cornerRadius(value: 5)
        customerNameTextField.widthAnchor.constraint(equalToConstant: screenWidth/1.1).isActive = true
        customerNameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupDivderLines(){
        let lineView1 = UIView(frame: CGRect(x: 16,
        y:  -5 ,
        width: screenWidth/1.1,
        height: 1))
        
        let lineView2 = UIView(frame: CGRect(x: 16,
                                             y:  40 ,
                                             width: screenWidth/1.1,
                                             height: 1))
        lineView1.backgroundColor = UIColor.lightGray
               paymentStackView.addSubview(lineView1)
    
        lineView2.backgroundColor = UIColor.lightGray
        paymentStackView.addSubview(lineView2)
    }
    
    @objc func payButtonPressed(){
        
        if customerEmailFromShippingForm != "" {
        self.present(loadingViewController, animated: false)
        performPaymentProcess()
        
        } else {
            let alert = UIAlertController(title: "Missing Info", message: "Please select address and enter all the required shipping fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func addShippingAddressPressed(){
        print("shipping address button pressed")
        self.config.requiredShippingAddressFields = [.postalAddress, .emailAddress]
        self.paymentContext.presentShippingViewController()
    }
    
    func getPaymentSectionTitle() -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.text = "Card Payment"
        return label
    }
    
    func calculateTotalCostForStripe() -> String {
        var stripeStringValueToReturn = ""
        var totalStringPrice = StripeCheckoutViewController.totalCostLabel.text //take the price showen on screen to user
        
        
        totalStringPrice = totalStringPrice?.replacingOccurrences(of: "€", with: "")//remove € symbol before casting to double
        let totalPriceAsDouble = (totalStringPrice! as NSString).doubleValue
        let costInCentsString = "\(totalPriceAsDouble * 100)"  //Stripe does everything in cents
        
        //remove everything after decimal point so small we dont care about
        if let i = costInCentsString.firstIndex(of: ".") {
            print(costInCentsString.prefix(upTo: i))
            stripeStringValueToReturn = String(costInCentsString.prefix(upTo: i))
        }
        
        return stripeStringValueToReturn
    }
}


