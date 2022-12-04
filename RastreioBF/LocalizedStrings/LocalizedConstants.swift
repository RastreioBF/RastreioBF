//
//  LocalizedConstants.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import Foundation
import UIKit

typealias LC = LocalizedConstants

enum LocalizedConstants: String {
    
    //MARK: - Login Screen
    case loginLabel
    case forgotPasswordBt
    case login
    case optionalLabel
    case newHere
    case signUp
    
    //MARK: - SignUp Screen
    case signUpLabel
    case alreadyMember
    case emailPlaceHolder
    case passwordPlaceHolder
    case namePlaceHolder
    case surnamePlaceHolder
    case confirmPasswordPlaceHolder
    
    //MARK: - Error Messages
    case loginErrorMessageLabel
    case emptyNameError
    case emptySurnameError
    case emptyEmailError
    case emptyPasswordError
    case emptyConfirmPasswordError
    case emailFormatError
    case passwordTargetError
    case passwordsNotEqualError
    case fieldsMustBeFilleds
    case allFieldsMustBeFilleds
    case wrongData
    case nameTargetError
    case surnameTargetError
    
    //MARK: - TabBar ViewControllers
    case menuTitle
    case homeTitle
    case warningTitle
    case pendenciesTitle
    case doneTitle
    
    //MARK: - Onboarding
    case firstSubtitle
    case secondSubtitle
    case thirdSubtitle
    case skipIntroductionBt
    case rastreioBFBt
    
    //MARK: - Alert Messages
    case atentionTitle
    case insertEmailBody
    case emailSent
    case linkSentMesageBody
    case verifyAndTryAgain
    case errorOccurred
    case wrongEmailSignin
    case tryAgainLater
    case correctlyFilled
    case congrats
    case emailSentConfirm
    
    var text: String {
        return rawValue.localized(.presentation)
    }
}
