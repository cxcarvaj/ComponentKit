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
    case isValidUsername
}

extension ValidationFunctions {
    public func validate(_ value: String) -> LocalizedStringResource? {
        switch self {
        case .isNotEmpty:
            !value.isEmpty ? nil : " field is required."
        case .isEmail:
            isValidEmail(value) ? nil : " not a valid email."
        case .isValidUsername:
            validStringLength(value, min: 8, max: 32) ? nil : " must be between 8 and 32 characters."
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = /^(?:[A-Z0-9a-z._%+-]+)@(?:[A-Za-z0-9-]+\.)+[A-Za-z]{2,63}$/
        return email.wholeMatch(of: emailRegex) != nil
    }
    
    private func validStringLength(_ value: String, min: Int, max: Int) -> Bool {
        (min...max).contains(value.count)
    }
}
