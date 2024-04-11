//
//  BankAdressesViewController.swift
//  BettaBank
//
//  Created by Борис Кравченко on 27.11.2023.
//

import UIKit
import YandexMapsMobile
import SnapKit

private enum Constants {
    static let bankInfoViewWindowHeight: CGFloat = 228
}

final class BankAddressesViewController: UIViewController, YMKMapObjectTapListener {

    var mapView: YMKMapView!
    var branchInfoDict: [YMKPlacemarkMapObject: BankBranchInfo] = [:]

    // MARK: - lifeCycle
    override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            title = BankViewTextConstants.BankAddressesTitle
            setupMapView()
            addPlacemarks()
        }

        // MARK: - UI Configure
        private func setupMapView() {
            mapView = YMKMapView()
            view.addSubview(mapView)

            mapView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
            }

            guard let mapView = mapView else {
                print("MapView is nil")
                return
            }

            mapView.mapWindow.map.move(
                with: YMKCameraPosition(
                    target: YMKPoint(latitude: MapCoordinates.startLatitude, longitude: MapCoordinates.startLongitude),
                    zoom: MapCoordinates.startZoom,
                    azimuth: MapCoordinates.startAzimuth,
                    tilt: MapCoordinates.starTilt
                ),
                animation: YMKAnimation(type: YMKAnimationType.smooth, duration: MapCoordinates.mapZoomDuration),
                cameraCallback: nil)
        }

    // MARK: - adding points to the map
        private func addPlacemarks() {
            guard let mapView = mapView else {
                print("MapView is nil")
                return
            }

            let bankBranch1Info = BankInfoExamples.branch1
            let bankBranch2Info = BankInfoExamples.branch2
            let atm1Info = BankInfoExamples.atm1
            let atm2Info = BankInfoExamples.atm2

            let bankBranches: [BankBranchInfo] = [bankBranch1Info, bankBranch2Info]
            let atms: [BankBranchInfo] = [atm1Info, atm2Info]

            for branchInfo in bankBranches {
                addPlacemark(for: branchInfo, with: "office", on: mapView)
            }

            for atmInfo in atms {
                addPlacemark(for: atmInfo, with: "atm", on: mapView)
            }
        }

        private func addPlacemark(for branchInfo: BankBranchInfo, with iconName: String, on mapView: YMKMapView) {
            let point = YMKPoint(latitude: branchInfo.latitude, longitude: branchInfo.longitude)
            let placemark = mapView.mapWindow.map.mapObjects.addPlacemark()

            placemark.geometry = point
            placemark.setIconWith(UIImage(resource: iconName) ?? UIImage(resource: .office))
            placemark.addTapListener(with: self)
            branchInfoDict[placemark] = branchInfo
        }

    // MARK: - adding taps to the points
        func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
            if let placemark = mapObject as? YMKPlacemarkMapObject,
               let branchInfo = branchInfoDict[placemark] {
                
                let bankInfoView = BankInfoView()
                bankInfoView.configure(with: branchInfo)

                view.addSubview(bankInfoView)

                bankInfoView.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                    make.leading.equalToSuperview().offset(Size.middleXL)
                    make.trailing.equalToSuperview().offset(-Size.middleXL)
                    make.height.equalTo(Constants.bankInfoViewWindowHeight)
                }
            }
            return true
        }
    }

extension UIImage {
    convenience init?(named: String) {
        self.init(named: named, in: Bundle.main, compatibleWith: nil)
    }

    convenience init?(resource: String) {
        self.init(named: resource)
    }
}
