//
//  ListOrderInteractor.swift
//  CleanArchitecture
//
//  Created by Eldon Chan on 3/27/18.
//  Copyright (c) 2018 ByEldon. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListOrderBusinessLogic
{
  func doSomething(request: ListOrder.Something.Request)
}

protocol ListOrderDataStore
{
  //var name: String { get set }
}

class ListOrderInteractor: ListOrderBusinessLogic, ListOrderDataStore
{
  var presenter: ListOrderPresentationLogic?
  var worker: ListOrderWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: ListOrder.Something.Request)
  {
    worker = ListOrderWorker()
    worker?.doSomeWork()
    
    let response = ListOrder.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
