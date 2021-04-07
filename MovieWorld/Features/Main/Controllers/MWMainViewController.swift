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
        self.sendPopularRequest()
        self.sendUpcomingMovieRequest()
        self.sendTopRatedMovieRequest()
    }

    @objc private func refreshPulled() {
        self.sendPopularRequest()
        self.sendUpcomingMovieRequest()
        self.sendTopRatedMovieRequest()
    }

    private func sendTopRatedMovieRequest() {
        MWNetwork.sh.request(urlPath: MWURLPaths.topRatedMovies) { [weak self] (topRatedMovies: MWTopRatedMovies) in
            guard let self = self else { return }
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.movies[.topRated] = topRatedMovies.results
            self.tableView.reloadData()

            topRatedMovies.results.forEach {
                Swift.debugPrint("id: \($0.id)")
                Swift.debugPrint($0.title)
                Swift.debugPrint($0.overview ?? "haven't overview")

            }
        } errorHandler: {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            print("error")
        }

    }

    private func sendUpcomingMovieRequest() {
        MWNetwork.sh.request(urlPath: MWURLPaths.upcomingMovies) { [weak self] (upcomingMovieModel: MWUpcomingMovies) in
            guard let self = self else { return }
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.movies[.upcoming] = upcomingMovieModel.results
            self.tableView.reloadData()

            upcomingMovieModel.results.forEach {
                Swift.debugPrint("id: \($0.id)")
                Swift.debugPrint($0.title)
                Swift.debugPrint($0.overview ?? "haven't overview")
                
            }
        } errorHandler: {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            print("error")
        }

    }

    private func sendPopularRequest() {
        MWNetwork.sh.request(urlPath: MWURLPaths.popularMovies) { [weak self](popularMovieModel: MWPopularMoviesResponce) in
            guard let self = self else { return }
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.movies[.popular] = popularMovieModel.results
            
            self.tableView.reloadData()

            popularMovieModel.results.forEach {
                        Swift.debugPrint("id: \($0.id)")
                        Swift.debugPrint($0.title)
                        Swift.debugPrint($0.overview ?? "No overview")
                    }
        } errorHandler: {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            print("error")
        }


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

