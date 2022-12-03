//
//  WeatherByHourCell.swift
//  AppWeather
//
//  Created by Irisandromeda on 02.12.2022.
//

import UIKit

//MARK: - Collection View Cell 

class WeatherByHourCell: UICollectionViewCell {
    
    static let reuseId: String = "WeatherByHourCell"
    
    let timeLabel = UILabel(text: "11:00", font: .systemFont(ofSize: 16), color: .white)
    let imageView = UIImageView(image: UIImage(), contentMode: .scaleAspectFit)
    let temperatureLabel = UILabel(text: "17°", font: .systemFont(ofSize: 16), color: .white)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        timeLabel.textAlignment = .center
        temperatureLabel.textAlignment = .center
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        let stackView = UIStackView(arrangedSubviews: [timeLabel,imageView,temperatureLabel], axis: .vertical, spacing: 5)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        ])
    }
    
}
