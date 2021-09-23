//
//  ViewController.swift
//  QRcode reader
//
//  Created by 西村勇登 on 2021/09/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let myQRCodeReader = MyQRCodeReader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myQRCodeReader.delegate = self
               myQRCodeReader.setupCamera(view:self.view)
               //読み込めるカメラ範囲
               myQRCodeReader.readRange()
    }
}
extension ViewController: AVCaptureMetadataOutputObjectsDelegate{
    //対象を認識、読み込んだ時に呼ばれる
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        //一画面上に複数のQRがある場合、複数読み込むが今回は便宜的に先頭のオブジェクトを処理
        if let metadata = metadataObjects.first as? AVMetadataMachineReadableCodeObject{
            let barCode = myQRCodeReader.previewLayer.transformedMetadataObject(for: metadata) as! AVMetadataMachineReadableCodeObject
            //読み込んだQRを映像上で枠を囲む。ユーザへの通知。必要な時は記述しなくてよい。
            myQRCodeReader.qrView.frame = barCode.bounds
            //QRデータを表示
            if let str = metadata.stringValue {
                print(str)
            }
        }
    }
}
