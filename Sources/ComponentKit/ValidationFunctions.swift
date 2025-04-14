//
//  ValidationFunctions.swift
//  EmployeesAPI
//
//  Created by Carlos Xavier Carvajal Villegas on 13/4/25.
//

import Foundation

public enum ValidationFunctions {
    case isNotEmpty
    case isEmail
}

extension ValidationFunctions {
    public func validate(_ value: String) -> String? {
        switch self {
        case .isNotEmpty:
            !value.isEmpty ? nil : "Field is required"
        case .isEmail:
            isValidEmail(value) ? nil : "Not a valid email"
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = /^(?:[A-Z0-9a-z._%+-]+)@(?:[A-Za-z0-9-]+\.)+[A-Za-z]{2,63}$/
        return email.wholeMatch(of: emailRegex) != nil
    }
}
