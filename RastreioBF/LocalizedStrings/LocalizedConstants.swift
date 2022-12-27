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
    case dataMustBeFilledMessage
    case alreadyRegisteredMessage
    case dataSalvedTitle
    case dataSavedMessage
    case wrongCodeMessage
    case okButton
    case calcelButton
    case requestDataTitle
    case requestDataMessage
    case sendTitle
    case emailTitle
    case removeDataTitle
    case removeDataMessage
    case leaveConfirmation
    case continueButton
    case pendenciesFilter
    case onItsWayFilter
    case deliveredFilter
    case allFilter
    
    
    //MARK: - Forgot Password
    case insertRegisteredEmail
    case sendEmailTextButton
    
    //MARK: - EmptyState
    case nothingHere
    
    //MARK: - Tracking
    case fillDataMessage
    case trackingCode
    case topMessage
    case descriptionTracking
    case insertDescription
    
    //MARK: - Assets Helper
    case errorImage
    case doneImage
    case onItsWayImage
    case redColor
    case greenColor
    case orangeColor
    case mainPurpleColor
    case homeIcon
    case trackingIcon
    case menuIcon
    case filterIcon
    
    //MARK: - Warning
    case payment
    case analysis
    case customs
    case missing
    case delivered
    case toBeDelivered
    case deliveredCaps
    
    //MARK: - Tabbar
    case homeTitleTab
    case trackingTitleTab
    case menuTitleTab
    
    //MARK: - Coredata
    case dataProduct
    case dataModel
    
    //MARK: - Settings Helper
    case signInConfig
    case urlAPI
    case urlAPIMock
    
    //MARK: - Privacy Policy
    case policy
    case title
    
    var text: String {
        return rawValue.localized(.presentation)
    }
}
