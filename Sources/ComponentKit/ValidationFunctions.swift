//
//  ValidationFunctions.swift
//  EmployeesAPI
//
//  Created by Carlos Xavier Carvajal Villegas on 13/4/25.
//

import Foundation

enum ValidationFunctions {
    case isNotEmpty((String) -> String?)
    case isEmail((String) -> String?)
}

extension ValidationFunctions {
    var function: ((String) -> String?) {
        switch self {
        case .isNotEmpty:
            { !$0.isEmpty ? nil : "Field is required"}
        case .isEmail:
            { isValidEmail($0) ? nil : "Not a valid email"}
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = /^(?:[A-Z0-9a-z._%+-]+)@(?:[A-Za-z0-9-]+\.)+[A-Za-z]{2,63}$/
        return email.wholeMatch(of: emailRegex) != nil
    }
}
