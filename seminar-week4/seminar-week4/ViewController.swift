//
//  ViewController.swift
//  seminar-week4
//
//  Created by 김민재 on 2023/05/06.
//

import UIKit

class ViewController: UIViewController {
    private var networkResult: [CityWeather]?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        getResult()
        getWeather()
    }


    private func setLayout() {

    }


}


extension ViewController {
    private func getWeather() {
        CityWeatherService.shared.getCityWeather(cityName: "seoul") { response in
            print(response)
            switch response {
            case .success(let data):
                guard let data = data as? CityWeather else { return }

                self.networkResult?.append(data)


            default:
                print("failed")
                return
            }
        }
    }
}


//{
//    "cities" : [
//        {
//            "name":
//            "weather":...
//        },
//        {
//            "name":
//            "weather":...
//        },
//        {
//            "name":
//            "weather":...
//        },
//        {
//            "name":
//            "weather":...
//        },
//        {
//            "name":
//            "weather":...
//        },
//    ]
//
//}
