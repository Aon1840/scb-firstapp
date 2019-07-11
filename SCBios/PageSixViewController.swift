//
//  PageSixViewController.swift
//  SCBios
//
//  Created by Attapon Peungsook on 8/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Charts
import DynamicColor
import UIKit

class PageSixViewController: UIViewController {
    @IBOutlet var mChartView: LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        createLineChart()
        // Do any additional setup after loading the view.
    }

    func createLineChart() {
        // Chart Configure
        mChartView.chartDescription?.text = "www.codemobiles.com"
        mChartView.setExtraOffsets(left: 0, top: 0, right: 30, bottom: 0)

        mChartView.chartDescription?.font = UIFont.boldSystemFont(ofSize: 15)
        mChartView.xAxis.labelPosition = .bottom
        mChartView.leftAxis.enabled = true
        mChartView.rightAxis.enabled = false

        // Set colors
        view.backgroundColor = UIColor(hexString: "#252934")
        mChartView.chartDescription?.textColor = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.9)
        mChartView.leftAxis.labelTextColor = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.3)
        mChartView.leftAxis.gridColor = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.1)
        mChartView.legend.textColor = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.3)
        mChartView.xAxis.gridColor = UIColor(hexString: "#9d9272").withAlphaComponent(0.1)
        mChartView.xAxis.labelTextColor = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.3)
        mChartView.backgroundColor = UIColor.clear
        mChartView.gridBackgroundColor = UIColor.clear

        let chartData = LineChartData()
        chartData.addDataSet(getDataSet1())
        chartData.addDataSet(getDataSet2())
        mChartView.data = chartData
    }

    func getDataSet1() -> LineChartDataSet {
        let rawData = [18500.0, 18550.0, 18650.0, 18650.0]
        var dataEntry: [ChartDataEntry] = []

        for i in 0 ... 3 {
            dataEntry.append(ChartDataEntry(x: Double(i), y: rawData[i]))
        }

        // Graphic configure
        let dataSet = LineChartDataSet(entries: dataEntry, label: "GOLD")

        dataSet.valueFont = UIFont.boldSystemFont(ofSize: 14)
        dataSet.valueFormatter = ValueFormatter()

        // dataSet.drawFilledEnabled = true
        // dataSet.fillColor = UIColor(hexString: "#6D95E8")
        // dataSet.fillAlpha = 0.3
        dataSet.lineWidth = 4
        dataSet.mode = .cubicBezier
        dataSet.fillColor = UIColor(hexString: "#3FB4FC")
        dataSet.fillAlpha = 0.3
        dataSet.circleRadius = 10
        dataSet.circleHoleRadius = 7
        dataSet.colors = [UIColor(hexString: "#3FB4FC")]
        dataSet.setCircleColor(UIColor(hexString: "#252934"))
        dataSet.valueColors = [UIColor(hexString: "#FFFFFF")]
        dataSet.circleHoleColor = UIColor(hexString: "#3FB4FC")

        return dataSet
    }

    func getDataSet2() -> LineChartDataSet {
        let rawData = [18550.0, 18500.0, 18650.0, 18650.0]
//        let rawData = [18500.0, 18550.0, 18650.0, 18650.0]
        var dataEntry: [ChartDataEntry] = []

        for i in 0 ... 3 {
            dataEntry.append(ChartDataEntry(x: Double(i), y: rawData[i]))
        }

        // Graphic configure
        let dataSet = LineChartDataSet(entries: dataEntry, label: "GOLD")

        dataSet.valueFont = UIFont.boldSystemFont(ofSize: 14)
        dataSet.valueFormatter = ValueFormatter()

        // dataSet.drawFilledEnabled = true
        // dataSet.fillColor = UIColor(hexString: "#6D95E8")
        // dataSet.fillAlpha = 0.3
        dataSet.lineWidth = 4
        dataSet.mode = .cubicBezier
        dataSet.fillColor = UIColor(hexString: "#d95730")
        dataSet.fillAlpha = 0.3
        dataSet.circleRadius = 10
        dataSet.circleHoleRadius = 7
        dataSet.colors = [UIColor(hexString: "#d95730")]
        dataSet.setCircleColor(UIColor(hexString: "#252934"))
        dataSet.valueColors = [UIColor(hexString: "#FFFFFF")]
        dataSet.circleHoleColor = UIColor(hexString: "#d95730")

        return dataSet
    }

    @objc(ValueFormatter)
    public class ValueFormatter: NSObject, IValueFormatter {
        public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
            return String(format: "%.0f", locale: Locale.current, Double(value))
        }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
