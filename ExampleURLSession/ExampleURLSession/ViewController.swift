//
//  ViewController.swift
//  ExampleURLSession
//
//  Created by Thirawuth on 22/11/2563 BE.
//

import UIKit

extension ViewController: URLSessionDelegate {
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        let protectionSpace = challenge.protectionSpace
        guard protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust else {return}
        guard protectionSpace.host.contains("thailandplus.com") else {
            completionHandler(.cancelAuthenticationChallenge, .none)
            return
        }
        guard let serverTrust = protectionSpace.serverTrust else {return}
        if checkValidity(server: serverTrust) {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.cancelAuthenticationChallenge, .none)
        }
    }
    
    func checkValidity(server: SecTrust) -> Bool {
        let bundleCer = Certificates.certificate(filename: "thailand")
        let serverCert = SecTrustGetCertificateAtIndex(server, 0)
        
        let bundleCertData = SecCertificateCopyData(bundleCer) as NSData
        let serverCertData = SecCertificateCopyData(serverCert!) as NSData
        
        return serverCertData.isEqual(to: bundleCertData as Data)
    }
}

struct Certificates {
    static func certificate(filename: String) -> SecCertificate {
        let filePath = Bundle.main.path(forResource: filename, ofType: "der")!
        //.pem.cer
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let certificate = SecCertificateCreateWithData(.none, data as CFData)!
        return certificate
    }
}

class ViewController: UIViewController {

    private var session: URLSession!
//    private let session = URLSession(configuration: .ephemeral)
    private var dataTask: URLSessionDataTask!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.setValue("Champ", forKey: "profile.filename")
        UserDefaults.standard.setValue("Chai", forKey: "profile.lastname")
        
        let firstname = UserDefaults.standard.string(forKey: "profile.filename")
        print(firstname)
        session = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: .none)
        searchSong("Sonic")
//        postSong("Sonic")
        
    }
    
    // MARK: - search song
    func searchSong(_ name: String) {
        dataTask.cancel()
        // https://itunes.apple.com/search?media=music&entity=song&term=Sonic
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        components.queryItems = [
            URLQueryItem(name: "media", value: "music"),
            URLQueryItem(name: "entity", value: "song"),
            URLQueryItem(name: "term", value: name),
        ]
        
        let url = components.url!
        dataTask = session.dataTask(
            with: url,
            completionHandler: ({ [weak self] data, response, error in
                if let error = error {
                    print("error :: \(error.localizedDescription)")
                    return
                }
                guard let response = response as? HTTPURLResponse else {return}
                guard response.statusCode == 200 else {return}
                guard let data = data else {return}
                let result = String(decoding: data, as: UTF8.self)
                DispatchQueue.main.async {
                    print("success :: \(result)")
                }
                self?.dataTask = nil
            })
        )
        
        dataTask.resume()
    }
    
    struct Authen: Encodable {
        let username: String
        let password: String
    }
    // MARK: - post song
    func postSong(_ name: String) {
        dataTask.cancel()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        
        let url = components.url!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let authenBody = Authen(username: "test", password: "1234")
        let encoded = try? JSONEncoder().encode(authenBody)
        urlRequest.httpBody = encoded
        
        dataTask = session.dataTask(with: urlRequest, completionHandler: { [weak self ](data, response, error) in
            if let error = error {
                print("error :: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {return}
            guard response.statusCode == 200 else {return}
            guard let data = data else {return}
            let result = String(decoding: data, as: UTF8.self)
            DispatchQueue.main.async {
                print("success :: \(result)")
            }
            self?.dataTask = nil
            
        })
    }


}

