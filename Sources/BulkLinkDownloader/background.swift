import Cocoa

public class BackgroundDownloader: URLSessionDelegate, URLSessionDownloadDelegate{

    private var downloadQueue: [URLSession] = []
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "MySession")
        config.isDiscretionary = true
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()

    func addDownloadToQueue(address: String){
        let url = URL(string: address)!
        let backgroundTask = urlSession.downloadTask(with: url)
        downloadQueue.append(backgroundTask)
    }

    func runAllDownloads(){
        downloadQueue.forEach {$0.resume()}
    }

    func urlSession(URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo: URL) {
        print("called completion handler")
    }

}
