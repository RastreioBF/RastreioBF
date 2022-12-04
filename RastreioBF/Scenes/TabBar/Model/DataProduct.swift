//
//  DataProduct.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 17/09/22.
//

import Foundation

class DataProduct{
    var productName : String
    var productNameImage: String
    var codeTraking : String
    var productDescription: String
    var date: String
    var time: String
    var status: String
    
    init(productName: String, productNameImage: String, codeTraking: String, productDescription: String, date: String, time: String, status: String) {
        self.productName = productName
        self.productNameImage = productNameImage
        self.codeTraking = codeTraking
        self.productDescription = productDescription
        self.date = date
        self.time = time
        self.status = status
    }
    
}
