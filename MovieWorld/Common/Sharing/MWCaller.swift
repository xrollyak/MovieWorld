//
//  MWCaller.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 5.04.21.
//

import UIKit
import MessageUI

class MWCaller {

    enum SocialNetwork {
        case skype(id: String)
        case facebook(id: String)
        case tikTok(id: String)
        case instagram(id: String)
        case twitter(id: String)
        case youtube(id: String)
        case telegram(id: String)

        var openUrls: (appScheme: String?, url: String) {
            switch self {
            case .skype(let skype):
                return ("skype://\(skype)?call",
                        "https://apps.apple.com/us/app/skype-for-iphone/id304878510")
            case .facebook(let profileId):
                return ("fb://profile/\(profileId)",
                        "https://facebook.com/\(profileId)")
            case .tikTok(let profileId):
                return (nil, "https://vm.tiktok.com/\(profileId)")
            case .instagram(let profileId):
                return ("instagram://user?username=\(profileId)",
                        "https://www.instagram.com/\(profileId)")
            case .twitter(let profileId):
                return ("twitter://user?screen_name=\(profileId)",
                        "https://twitter.com/\(profileId)")
            case .youtube(let profileId):
                return ("youtube://\(profileId)",
                        "https://www.youtube.com/user/\(profileId)")
            case .telegram(let profileId):
                return ("tg://resolve?domain=\(profileId)",
                        "https://t.me/\(profileId)")
            }
        }
    }

    class func canOpenUrl(_ urlString: String) -> Bool {
        guard let url = URL(string: urlString) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }

    @discardableResult
    class func openUrl(_ urlString: String,
                       options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:],
                       completionHandler completion: ((Bool) -> Void)? = nil) -> Bool {
        guard let url = URL(string: urlString), self.canOpenUrl(urlString) else { return false }
        UIApplication.shared.open(url, options: options, completionHandler: completion)
        return true
    }

    class func openPhone(_ phone: String) {
        self.openUrl("tel://" + phone)
    }

    @discardableResult
    class func openMail(emailSubject: String, toEmail: String, body: String) -> Bool {
        return self.openUrl("mailto:\(toEmail)?subject=\(emailSubject)&body=\(body)")
    }

    @discardableResult
    class func openMail(emailSubject: String, toEmail: String, url: URL? = nil) -> Bool {
        var bodyString: String = ""
        if let url = url {
            bodyString = "&body=\(url.absoluteString)"
        }
        let path = "mailto:\(toEmail)?subject=\(emailSubject)\(bodyString)"
        return self.openUrl(path)
    }

    class func open(socialNetwork: SocialNetwork) {
        let (appScheme, url) = socialNetwork.openUrls
        guard let scheme = appScheme, self.openUrl(scheme) else {
            self.openUrl(url)
            return
        }
    }

    /// true - if at least one email account is enabled on the device
    @discardableResult
    class func openMailWithVC(emailSubject: String = "",
                              toEmail: String,
                              body: String? = nil,
                              isHTML: Bool = false,
                              delegate: MFMailComposeViewControllerDelegate) -> Bool {
        guard MFMailComposeViewController.canSendMail() else { return false }

        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = delegate
        mailVC.setSubject(emailSubject)
        mailVC.setToRecipients([toEmail])
        if let body = body {
            mailVC.setMessageBody(body, isHTML: isHTML)
        }
        MWI.sh.currentNavController.present(mailVC, animated: true)

        return true
    }
}
