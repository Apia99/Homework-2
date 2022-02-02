//
//  ViewController.swift
//  Homework 2 Get Data from API
//
//  Created by Admin on 01/02/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=Q9YNbzmt8C5OpY7L3MV4DHJhrdIGCbjx3tVWxRcf&sol=2000&page=1"
        getData(from: url)
    }
    private func getData(from url: String) {
        
       let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("someething went wrong")
                return
            }
            
            var result: Response?
            do {
                result  = try JSONDecoder().decode(Response.self, from: data)
            }
            catch{
                print("failed to convert \(error.localizedDescription)")
            }
            guard let json = result else {
                return
            }
           
           let photos = result?.photos ?? []
           let firstPhoto = photos.first
           
           print(result?.photos.first?.img_src)
           print(firstPhoto?.sol)
           print(firstPhoto?.camera.name)
           print(firstPhoto?.rover.status)
           print(firstPhoto?.id)
           print(firstPhoto?.earth_date)

        })
            task.resume()
        
    }

}

struct Response: Codable {
    let photos: [MyPhoto]
}
struct MyPhoto: Codable  {
    let id: Int
    let sol: Int
    let earth_date: String
    let img_src: String
    let rover: Rover
    let camera: Camera
}
struct Rover: Codable {
    let id: Int
    let name: String
    let  landing_date:String
    let launch_date: String
    let status: String
}
struct Camera: Codable {
    let full_name: String
    let name: String
    let rover_id: Int
    let id: Int
}
