//
//  MainViewController.swift
//  AppWeather
//
//  Created by Irisandromeda on 28.11.2022.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    var collectionView: UICollectionView = {
        let collectionViewLoyaout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLoyaout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .lightBlue()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(WeatherByHourCell.self, forCellWithReuseIdentifier: WeatherByHourCell.reuseId)
        collectionView.register(WeatherByDayCell.self, forCellWithReuseIdentifier: WeatherByDayCell.reuseId)
        
        return collectionView
    }()
    
    let weatherImage = UIImageView(image: UIImage(named: "ic_white_day_cloudy")!, contentMode: .scaleAspectFit)
    let temperatureImage = UIImageView(image: UIImage(named: "ic_temp")!, contentMode: .scaleAspectFit)
    let humidityImage = UIImageView(image: UIImage(named: "ic_humidity")!, contentMode: .scaleAspectFit)
    let windImage = UIImageView(image: UIImage(named: "ic_wind")!, contentMode: .scaleAspectFit)
    
    let dateLabel = UILabel(text: "", font: .systemFont(ofSize: 16), color: .white)
    let temperatureLabel = UILabel(text: "", font: .systemFont(ofSize: 16), color: .white)
    let humidityLabel = UILabel(text: "", font: .systemFont(ofSize: 16), color: .white)
    let windLabel = UILabel(text: "", font: .systemFont(ofSize: 16), color: .white)
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .mainBlue()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setDelegates()
        addConstraints()
        configureBarButtonItems()
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    private func configureBarButtonItems() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_my_location"), style: .plain, target: self, action: #selector(rightButtonTap))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_place"), style: .plain, target: self, action: #selector(leftButtonTap))
        navigationItem.backButtonTitle = ""
    }
    
    @objc private func rightButtonTap() {
        
    }
    
    @objc private func leftButtonTap() {
        let findViewController = ModelsBuilder.createFindModule()
        navigationController?.pushViewController(findViewController, animated: true)
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
    }
    
}

//MARK: - Constraints

extension MainViewController {
    
    private func addConstraints() {
        let imageStackView = UIStackView(arrangedSubviews: [temperatureImage,humidityImage,windImage], axis: .vertical, spacing: 10)
        let labelStackView = UIStackView(arrangedSubviews: [temperatureLabel,humidityLabel,windLabel], axis: .vertical, spacing: 10)
        let stackView = UIStackView(arrangedSubviews: [imageStackView,labelStackView], axis: .horizontal, spacing: 10)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(dateLabel)
        view.addSubview(weatherImage)
        view.addSubview(stackView)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            weatherImage.centerYAnchor.constraint(equalTo: stackView.centerYAnchor, constant: 0),
            weatherImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            weatherImage.heightAnchor.constraint(equalToConstant: 150),
            weatherImage.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

//MARK: - Setup Layout

extension MainViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in

            let section = self.presenter.pageData![sectionIndex]

            switch section {
            case .weatherByHour(_):
                return self.createWeatherByHour()
            case .weatherByDay(_):
                return self.createWeatherByDay()
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10
        layout.configuration = config

        return layout
    }

    private func createWeatherByHour() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(80), heightDimension: .absolute(100))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 10)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }

    private func createWeatherByDay() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(65))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 0

        return section
    }
}

//MARK: - Collection View Data Source

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.pageData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.pageData?[section].count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch presenter.pageData![indexPath.section] {
            
        case .weatherByHour(let dataByHours):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherByHourCell.reuseId, for: indexPath) as? WeatherByHourCell else { return UICollectionViewCell() }
            let weather = dataByHours.list[indexPath.row]
            cell.timeLabel.text = weather.date.getFormattedDate(format: "HH:mm")
            cell.imageView.image = UIImage(named: weather.weather[0].icon)
            cell.temperatureLabel.text = Int(weather.main.tempMin).description + "°"
            return cell
        case .weatherByDay(let dataByDays):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherByDayCell.reuseId, for: indexPath) as? WeatherByDayCell else { return UICollectionViewCell() }
            let weather = dataByDays.list[indexPath.row]
            cell.dateLabel.text = weather.date.getFormattedDate(format: "EEEEEE").uppercased()
            cell.temperatureLabel.text = Int(weather.main.tempMin).description + "°" + " / " + Int(weather.main.tempMax).description + "°"
            cell.weatherImage.image = UIImage(named: weather.weather[0].icon)
            return cell
        }
    }
}

extension MainViewController: MainViewProtocol {

    func updateWeatherInfo() {
        let weather = presenter.weather?.list[0]

        dateLabel.text = (weather?.date.getFormattedDate(format: "EEEEEE").uppercased() ?? "") + (weather?.date.getFormattedDate(format: ", d MMMM") ?? "")
        temperatureLabel.text = Int(weather?.main.tempMin ?? 0).description + "°" + " / " + Int(weather?.main.tempMax ?? 0).description + "°"
        humidityLabel.text = Int(weather?.main.humidity ?? 0).description + "%"
        windLabel.text = Int(weather?.wind.speed ?? 0).description + " м/сек"
        weatherImage.image = UIImage(named: (weather?.weather[0].icon) ?? "")
    }

    func success() {
        title = presenter.weather?.city.name
        collectionView.reloadData()
        updateWeatherInfo()
    }

    func failure(error: Error) {
        self.showAlert(title: "Something was wrong!", message: error.localizedDescription)
    }
}
