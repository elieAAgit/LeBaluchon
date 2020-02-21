//
//  UIViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 18/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Show alert
    @objc func actionAlert(notification: Notification) {
        var title = String()
        var message = String()

        guard let userInfo = notification.userInfo else { return }

        guard let alert = userInfo["Alert"] as? Notification.Alert else { return }

        /// Specific case of alerts
        switch alert {
            case .errorData :
                    title = "Erreur données"
                    message = "Aucunes données disponibles."
            case .languageUnknown :
                    title = "Langue inconnue"
                    message = "Une langue non reconnu a été détecté."
            case .languagesList :
                    title = "Erreur chargement des langues"
                    message = "La liste des langues est indisponible."
            case .currenciesRates :
                    title = "Données de conversion manquantes"
                    message = "La conversion de devises est indisponible."
            case .currenciesList :
                    title = "Erreur chargement des devises"
                    message = "La liste des devises est indisponible."
            case .currencyUnknown :
                    title = "Devise inconnu"
                    message = "Une devise inconnu a été détecté."
            case .citiesDisplay :
                    title = "Erreur"
                    message = "Impossible d'afficher la météo."
            case .cityForecast :
                title = "Erreur"
                message = "La prevision meteo sur plusieurs jours n'est pas disponible."
            case .inputError :
                    title = "Saisie erronée"
                    message = "Une erreur a été détecté lors de la saisie. Veuillez recommencer."
        }
        
        alertVC(title: title, message: message)
    }

    /// Present custom alert
    private func alertVC(title: String, message: String) {
        /*
         For a traditional alert with UIAlertController, use this:
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let action = UIAlertAction(title: "Revenir", style: .default, handler: nil)
         alert.addAction(action)
         */

        let alert = AlertService.alert(title: title, body: message, buttonTitle: "Revenir")

        /*
         present alert in tabbarcontroller to avoid error message: " Presenting view controllers on detached view controllers is discouraged"
         */

        self.tabBarController?.present(alert, animated: true, completion: nil)
    }
}
