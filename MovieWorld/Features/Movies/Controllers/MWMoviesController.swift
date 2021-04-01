//
//  MWMoviesController.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 1.04.21.
//

import Foundation

class MWMoviesController: MWViewController {

    private let imageUrls: [String] = [
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449750_6002",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449786_10224",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449816_4994",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449837_8094",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449855_9294",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449880_8311",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449900_4583",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449919_5720",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449947_12069",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449967_14631",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449989_39059",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450014_14191",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450043_41074",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450062_11754",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450097_12993",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450115_99828",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450133_2710",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450154_18007",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450174_26808",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450200_18730"
    ]

    private lazy var models: [MWMovieModel] = self.imageUrls.map { MWMovieModel(imageUrl: $0) }

    override func initController() {
        super.initController()

        self.controllerTitle = "Movies"
    }
}
