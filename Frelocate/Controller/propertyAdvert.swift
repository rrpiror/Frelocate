//
//  propertyAdvert.swift
//  
//
//  Created by Rob Prior on 22/01/2018.
//

import UIKit
import Firebase
import GoogleMobileAds
import MessageUI


class propertyAdvert: UIViewController, MFMailComposeViewControllerDelegate {

    var post: Post?
    static var imageCache = NSCache<NSString, UIImage>()
    
    //@IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var titleNavBar: UINavigationBar!
    @IBOutlet var valueLbl: UILabel!
    @IBOutlet var streetLbl: UILabel!
    @IBOutlet var locationLbl: UILabel!
    @IBOutlet var descriptionLbl: UITextView!
    
    @IBOutlet var mainImage: UIImageView!
    
    @IBOutlet var bannerView: GADBannerView!
    
    @IBOutlet var adHolderHeight: NSLayoutConstraint!
    @IBOutlet var removeAdsButton: UIButton!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView()

        //titleLbl.text = post?.title
        
        valueLbl.text = post?.value
        streetLbl.text = post?.street
        locationLbl.text = post?.location
        descriptionLbl.text = post?.detailedDescription
        titleNavBar.topItem?.title = post?.title
        
        
        downloadImg()
        
        
        if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_REMOVE_ADS) {
            removeAdsButton.removeFromSuperview()
            bannerView.removeFromSuperview()
            adHolderHeight.constant = 0
        } else {
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }

    }

    @IBAction func backToSearchProperties(_ sender: Any) {
        performSegue(withIdentifier: "backToSeaerchProperties", sender: self)
    }
    
    func textView() {
        descriptionLbl.layer.borderColor = UIColor.lightGray.cgColor
        descriptionLbl.layer.borderWidth = 1.0
        descriptionLbl.layer.cornerRadius = 5
    
    }
    
    func downloadImg() {
        let url = URL(string: (post?.imageUrl)!)
        if let data = try? Data(contentsOf: url!) {
            mainImage.image = UIImage(data: data)
        } else {
            mainImage.image = nil
        }
    }
    
    @IBAction func removeAdsPressed(_ sender: Any) {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        PurchaseManager.instance.purchaseRemoveAds { success in
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if success {
                self.bannerView.removeFromSuperview()
                self.removeAdsButton.removeFromSuperview()
                self.adHolderHeight.constant = 0
            }
        }
    }
    
    @IBAction func emailSeller(_ sender: Any) {
        let email = post?.email
        let emailTitle = "You have interest in your Frelocate Advert"
        let emailBody = "Hi, I am interested in your property that I have seen on Frelocate, please could you send me more information."
        let toRecipients = [email]
        
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(emailBody, isHTML: false)
        mc.setToRecipients(toRecipients as? [String])
        
        self.present(mc, animated: true, completion: nil)
    }
    
    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError) {
        switch result {
            
        case .cancelled:
            print("Mail cancelled")
        case .saved:
            print("Mail saved")
        case .sent:
            print("Mail sent")
        case .failed:
            print("Mail sent failure: \(error.localizedDescription)")
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    

    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
    }

    
}
