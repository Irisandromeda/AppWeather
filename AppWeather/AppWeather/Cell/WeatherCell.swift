//
//  WeatherCell.swift
//  AppWeather
//
//  Created by Irisandromeda on 28.11.2022.
//

//import UIKit
//
////MARK: - Weather Cell
//
//class WeatherCell: UITableViewCell {
//    static let reuseId = "WeatherCell"
//    
//    let dateLabel = UILabel(text: "Date", font: .systemFont(ofSize: 16), color: .black)
//    let temperatureLabel = UILabel(text: "Temperature", font: .systemFont(ofSize: 16), color: .black)
//    let weatherImage = UIImageView(image: UIImage(named: "ic_white_day_cloudy")!, contentMode: .scaleAspectFit)
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .white
//        addConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//extension WeatherCell {
//    private func addConstraints() {
//        dateLabel.translatesAutoresizingMaskIntoConstraints = false
//        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
//        weatherImage.translatesAutoresizingMaskIntoConstraints = false
//        
//        addSubview(dateLabel)
//        addSubview(temperatureLabel)
//        addSubview(weatherImage)
//        
//        NSLayoutConstraint.activate([
//            contentView.heightAnchor.constraint(equalToConstant: 60)
//        ])
//        
//        NSLayoutConstraint.activate([
//            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
//            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25)
//        ])
//        
//        NSLayoutConstraint.activate([
//            temperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
//            temperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
//        ])
//        
//        NSLayoutConstraint.activate([
//            weatherImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
//            weatherImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25)
//        ])
//    }
//}
//
