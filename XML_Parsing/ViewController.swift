
import UIKit

class ViewController: UIViewController,XMLParserDelegate,UITableViewDataSource{

    @IBOutlet weak var tbl: UITableView!
    var arr:[Any] = [];
    var brr:[String] = [];
    var strcontent:String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
       getdata()
    }
    
    func getdata()  {
        
        let url = URL(string:"https://timesofindia.indiatimes.com/rssfeedstopstories.cms");
        do {
            let dt = try Data(contentsOf: url!);
            let parser = XMLParser(data:dt);
            
            parser.delegate = self;
            parser.parse();
        } catch  {
            }
        }
   
    func parserDidStartDocument(_ parser: XMLParser) {
        
        arr = [];
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item"{
            brr = [];
        }
        
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "title" || elementName == "description" || elementName == "link"{
            brr.append(strcontent);
            
        }
        else if elementName == "item"{
            arr.append(brr);
        }
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        strcontent = string;
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let arr1 = arr[indexPath.row] as! [String];
        print(arr1)
        
        cell.textLabel?.text = arr1[0];
        cell.detailTextLabel?.text = arr1[1];
        
        return cell;
        
    }
}

