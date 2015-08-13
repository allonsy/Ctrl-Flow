import UIKit

class GoogleAuth : CFViewController {
    
    private let kKeychainItemName = "CtrlFlowGmailAPI"
    private let kClientID = "901680046415-2nfn70mvs0f3rjerdbar022o0i4793bq.apps.googleusercontent.com"
    private let kClientSecret = "24HsIgDngCdbDdn-yvHSfIi7"
    
    private let scopes = [kGTLAuthScopeGmailReadonly]
    
    private let service = GTLServiceGmail()
    let output = UITextView()
    
    // When the view loads, create necessary subviews
    // and initialize the Gmail API service
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.frame = view.bounds
        output.editable = false
        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        output.autoresizingMask = UIViewAutoresizing.FlexibleHeight |
            UIViewAutoresizing.FlexibleWidth
        
        view.addSubview(output);
        
        GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(
            kKeychainItemName,
            clientID: kClientID,
            clientSecret: kClientSecret
        )
    }
    
    // When the view appears, ensure that the Gmail API service is authorized
    // and perform API calls
    override func viewDidAppear(animated: Bool) {
        if let authorizer = service.authorizer,
            canAuth = authorizer.canAuthorize where canAuth {
                navigationController?.popViewControllerAnimated(true)
                //callbackDelegate?.objIsReady((indexPath!, service))
        } else {
            presentViewController(
                createAuthController(),
                animated: true,
                completion: nil
            )
        }
    }
    /*
    // Construct a query and get a list of upcoming labels from the gmail API
    func fetchLabels() {
        output.text = "Getting labels..."
        
        let query = GTLQueryGmail.queryForUsersMessagesList()
        service.executeQuery(query,
            delegate: self,
            didFinishSelector: "displayResultWithTicket:finishedWithObject:error:"
        )
    }
    
    // Display the labels in the UITextView
    func displayResultWithTicket(ticket : GTLServiceTicket,
        finishedWithObject labelsResponse : GTLGmailListMessagesResponse, //GTLGmailListLabelsResponse,
        error : NSError?) {
            
            if let error = error {
                showAlert("Error", message: error.localizedDescription)
                return
            }
            
            var labelString = ""
            
            if !labelsResponse.messages.isEmpty {
                labelString += "Labels:\n"
                for label in labelsResponse.messages as! [GTLGmailMessage] {
                    labelString += "\(label)\n"
                }
            } else {
                labelString = "No labels found."
            }
            output.text = labelString
            
    }*/
    
    // Creates the auth controller for authorizing access to Gmail API
    private func createAuthController() -> GTMOAuth2ViewControllerTouch {
        let scopeString = " ".join(scopes)
        return GTMOAuth2ViewControllerTouch(
            scope: scopeString,
            clientID: kClientID,
            clientSecret: kClientSecret,
            keychainItemName: kKeychainItemName,
            delegate: self,
            finishedSelector: "viewController:finishedWithAuth:error:"
        )
    }
    
    // Handle completion of the authorization process, and update the Gmail API
    // with the new credentials.
    func viewController(vc : UIViewController,
        finishedWithAuth authResult : GTMOAuth2Authentication, error : NSError?) {
            
            if let error = error {
                service.authorizer = nil
                showAlert("Authentication Error", message: error.localizedDescription)
                return
            }
            
            service.authorizer = authResult
            dismissViewControllerAnimated(true, completion: nil)
            callbackDelegate?.objIsReady((indexPath!, service))
            navigationController?.popViewControllerAnimated(true)
    }
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertView(
            title: title,
            message: message,
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        alert.show()
    }
}