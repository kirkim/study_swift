//
//  NetWorkingItunesAPI.swift
//  MyMovieApp
//
//  Created by 김기림 on 2022/01/18.
//

import Foundation

class NetWorkingItunesAPI {
    static let shared = NetWorkingItunesAPI()
    private var movieModel: ItunesDataModel?
    private var isReady: Bool = false
    private var count: Int = 0
    
    private init() { }
    
    public func prepareData() {
        print("NetWorkingItunesAPI - prepareData() called")
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        var components = URLComponents(string: "https://itunes.apple.com/search")
        let term = URLQueryItem(name: "term", value: "Marvel")
        let media = URLQueryItem(name: "media", value: "movie")
        components?.queryItems = [term, media]
        guard let url = components?.url else { fatalError() }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            print( (response as! HTTPURLResponse).statusCode )
            print("url: \(url)")
            if let hasData = data {
                do {
                    sleep(1)
                    self.movieModel = try JSONDecoder().decode(ItunesDataModel.self, from: hasData)
                    self.isReady = true
                } catch {
                    print("error: ", error)
                }
            }
        })
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    public func getData() -> ItunesDataModel? {
        print("NetWorkingItunesAPI - getData() called")
        if (self.isReady == false) {
            count += 1
            print("call getData(): ", count)
            usleep(100000)
            return getData()
        }
        return self.movieModel
    }
}
