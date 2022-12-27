//
//  PrivacyViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 26/12/22.
//

import Foundation

class PrivacyViewModel {
    
    private var localizedConstant: LocalizedConstants?
    private var policy: String? = LC.policy.text
    private var title: String? = LC.title.text
    
    func setPrivacyPolicy(policy: String?) {
        self.policy = policy
    }
    
    func getPrivacyPolicy() -> String? {
        return policy
    }
    
    func getTitle() -> String? {
        return title
    }
}
