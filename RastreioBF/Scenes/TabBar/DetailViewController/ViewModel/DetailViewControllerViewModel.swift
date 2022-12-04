//
//  DetailViewControllerViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

struct DetailViewControllerViewModel {
    
    private var trackingDataProductVM = TrackingViewControllerViewModel()
    private var doneDataProductVM = DoneViewControllerViewModel()
    private var pendenciesDataProductVM = PendenciesViewControllerViewModel()
    private var warningDataProductVM = WarningViewControllerViewModel()
    
    private static var data: DataProduct?
    
    func getDataProduct(indexPath: IndexPath) -> DataProduct {
        
        if DetailViewControllerViewModel.data?.status.lowercased() == "pendente"{
            DetailViewControllerViewModel.data = pendenciesDataProductVM.getDataProduct(indexPath: indexPath)
        } else if DetailViewControllerViewModel.data?.status.lowercased() == "entregue"{
            DetailViewControllerViewModel.data = doneDataProductVM.getDataProduct(indexPath: indexPath)
        } else {
            DetailViewControllerViewModel.data = warningDataProductVM.getDataProduct(indexPath: indexPath)
        }
        
        return DetailViewControllerViewModel.data ?? DataProduct(productName: "Sem dados ainda", productNameImage: "avisos", codeTraking: "N/A", productDescription: "Sem descrição", date: "N/A", time: "N/A", status: "Desconhecido")
    }
    
    var heightForRowAt: CGFloat {
        return 300
    }
}
