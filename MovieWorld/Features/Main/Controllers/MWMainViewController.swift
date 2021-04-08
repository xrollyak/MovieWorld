//
//  MWMainViewController.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 5.04.21.
//

import UIKit

class MWMainViewController: MWViewController {

    enum MovieCategory: String {
        case popular = "Popular"
        case upcoming = "Upcoming"
        case topRated = "Top Rated"
    }

    private var movies: [MovieCategory: [MWMovie]] = [:]

    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = UIColor(named: "accentColor")
        control.addTarget(self, action: #selector(refreshPulled),
                          for: .valueChanged)

        return control
    }()

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 305
        view.tableFooterView = UIView()
        view.separatorStyle = .none
        view.refreshControl = self.refreshControl

        view.register(MWRowCell.self, forCellReuseIdentifier: MWRowCell.reuseIdentifier)

        return view
    }()

    override func initController() {
        super.initController()

        self.controllerTitle = "Main"

        self.view.addSubview(self.tableView)

        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.sendPopularMoviesRequest()
        self.sendUpcomingRequest()
        self.sendTopRatedRequest()
    }

    @objc private func refreshPulled() {
        self.sendPopularMoviesRequest()
        self.sendUpcomingRequest()
        self.sendTopRatedRequest()
    }

    // MARK: - requests

    private func sendUpcomingRequest() {
        MWNetwork.sh.requestAlamofire(urlPath: MWUrlPaths.upcomingMovies) { [weak self] (upcomingMoviesModel: MWUpcomingResponseModel) in
            self?.handleResponse(for: .upcoming, movies: upcomingMoviesModel.results)

        } errorHandler: { [weak self] (error: MWNetError) in
            self?.handleError(error: error)
        }
    }

    private func sendTopRatedRequest() {
        MWNetwork.sh.requestAlamofire(urlPath: MWUrlPaths.topRatedMovies) { [weak self] (topRatedMoviesModel: MWTopRatedReponseModel) in
            self?.handleResponse(for: .topRated, movies: topRatedMoviesModel.results)
        } errorHandler: { [weak self] (error: MWNetError) in
            self?.handleError(error: error)
        }
    }

    private func sendPopularMoviesRequest() {
        MWNet.sh.requestAlamofire(
            urlPath: MWUrlPaths.popularMovies,
            parameters: nil,
            okHandler: { [weak self] (model: MWPopularMovieResponse) in
                self?.handleResponse(for: .popular, movies: model.results)
            },
            errorHandler: { [weak self] (error: MWNetError) in
                self?.handleError(error: error)
            })
    }

    // MARK: - handling responses

    private func handleResponse(for category: MovieCategory, movies: [MWMovie]) {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }

        self.movies[category] = movies

        self.tableView.reloadData()
    }

    private func handleError(error: MWNetError) {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }

        let title: String = "Error"
        var message: String = "Something went wrong!"
        switch error {
        case .incorrectUrl:
            message = "Incorrect URL"
        case .networkError(let error):
            message = error.localizedDescription
        default:
            break
        }

        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        self.present(alert, animated: true)
    }

}

extension MWMainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MWRowCell.reuseIdentifier, for: indexPath) as? MWRowCell ?? MWRowCell()
        let array = Array(self.movies)[indexPath.section]
        cell.movies = array.value
        cell.set(sectionName: array.key.rawValue)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Swift.debugPrint("user selected: \(indexPath)")
    }
}

