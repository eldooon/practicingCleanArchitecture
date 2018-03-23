//
//  CreateOrderViewController.swift
//  CleanArchitecture
//
//  Created by Eldon Chan on 3/22/18.
//  Copyright (c) 2018 ByEldon. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CreateOrderDisplayLogic: class
{
    func displaySomething(viewModel: CreateOrder.Something.ViewModel)
}

class CreateOrderViewController: UITableViewController, CreateOrderDisplayLogic, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    var interactor: CreateOrderBusinessLogic?
    var router: (NSObjectProtocol & CreateOrderRoutingLogic & CreateOrderDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = CreateOrderInteractor()
        let presenter = CreateOrderPresenter()
        let router = CreateOrderRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
        configurePickers()
    }
    
    // MARK: Do something
    
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = CreateOrder.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: CreateOrder.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    //Configure Pickers
    func configurePickers () {
        self.shippingSpeedTextField.inputView = shippingMethodPicker
    }
    
    //Textfields
    @IBOutlet var textFields: [UITextField]!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TEST TEST TEST")
        textField.resignFirstResponder()
        if let index = textFields.index(of: textField) {
            if index < textFields.count - 1 {
                let nextTextField = textFields[index + 1]
                nextTextField.becomeFirstResponder()
            }
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            for textField in textFields {
                if textField.isDescendant(of: cell) {
                    textField.becomeFirstResponder()
                }
            }
        }
    }
    
    //Customer Contact Info
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //Shipping Address
    @IBOutlet weak var shippingStreet1TextField: UITextField!
    @IBOutlet weak var shippingStreet2TextField: UITextField!
    @IBOutlet weak var shippingCityTextField: UITextField!
    @IBOutlet weak var shippingStateTextField: UITextField!
    @IBOutlet weak var shippingZipcodeTextfield: UITextField!
    
    //Shipping Method
    @IBOutlet weak var shippingSpeedTextField: UITextField!
    
    //Payment Information
    @IBOutlet weak var creditCardNumberTextField: UITextField!
    @IBOutlet weak var expirationTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    
    //Billing Address
    @IBOutlet weak var sameAsShippingSwitch: UISwitch!
    @IBOutlet weak var billingStreet1TextField: UITextField!
    @IBOutlet weak var billingStreet2TextField: UITextField!
    @IBOutlet weak var billingCityTextField: UITextField!
    @IBOutlet weak var billingStateTextField: UITextField!
    @IBOutlet weak var billingZipcodeTextField: UITextField!
    
    //Pickers
    @IBOutlet var shippingMethodPicker: UIPickerView!
    
    @IBOutlet var expirationDatePicker: UIDatePicker!
    
    @IBAction func expirationDatePickerValueChanged(_ sender: Any) {
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
}
