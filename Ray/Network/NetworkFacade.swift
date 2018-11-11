//
//  NetworkFacade.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import Foundation
import VK_ios_sdk
import Alamofire
import SwiftyJSON

final class NetworkFacade {
    func initiateUser() {
        guard let firstName = VKSdk.accessToken()?.localUser.first_name else { return }
        guard let lastName = VKSdk.accessToken()?.localUser.last_name else { return }
        guard let userId = VKSdk.accessToken()?.localUser.id else { return }
        let userJSON = JSON(dictionaryLiteral: ("vk_id", userId),
                            ("first_name", firstName), ("second_name", lastName))
        var userData: Data?
        do {
            userData = try userJSON.rawData()
        } catch {
            print("bad")
        }
        guard let data = userData else { return }
        let headers = HTTPHeaders(dictionaryLiteral: ("Content-Type", "application/json"))
        Alamofire.upload(data, to: dedicatedIp.appending(updateUserApi), headers: headers)
    }
    
    func getUser(id: Int) {
        dataTask?.cancel()
        //let handURL = "http://moodle.phystech.edu/login/index.php"
        let handURL = "http://172.20.37.113/api/users/users/40/"
        let url = URL(string: handURL)!
        print(url)
        
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        dataTask = session.dataTask(with: url, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            print(data)
            self?.dataTask = nil
        })
        dataTask?.resume()
    }
    
    private var dataTask: URLSessionDataTask?
    private let updateUserApi = "/api/users/users/"
    private let dedicatedIp = "http://172.20.37.113:1681"
}
