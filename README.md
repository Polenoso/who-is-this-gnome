# Know the Gnome
Mock project displaying a list of gnomes


## Architecture
### MVP
Usage of MVP (Model-View-Presenter) as main architecture for this project.
Written in [`Swift`](https://developer.apple.com/swift/).

The project is structured as:
-Infrastructure
-Interface
where,
`Infrastructure` :  Contains all the core of the project.
*Managers
*AppConfig
*Models

`Interface` : Contains the presentation busniess of the project.
* Scenes
* Services

### Deployment Target

- iOS 10.0+

## Frameworks
* [Alamofire](https://github.com/Alamofire/Alamofire) - The network library.

Alamofire is a supported framework with MIT license used to manage network requests easier. It gives features like:
- [x] Chainable Request / Response Methods
- [x] URL / JSON / plist Parameter Encoding
- [x ]Upload File / Data / Stream / MultipartFormData
- [x] Network Reachability

It also helps to do asynchronous tasks on network requests, leaving the main queue free for UI threads.


* [KingFisher](https://github.com/onevcat/Kingfisher) - The image library

Kingfisher is a supported framework with MIT license used to mange the image caching and presenting.
- [x] Asynchronous image downloading and caching.
- [x] `URLSession`-based networking. Basic image processors and filters supplied.
- [x] Multiple-layer cache for both memory and disk.

## Installation
### Carthage
To run the project Carthage is needed.

` [How to install carthage](https://github.com/Carthage/Carthage#user-content-installing-carthage) `

After installing carthage, open a new terminal session, navigate to project folder under knowTheKnome directory.

run ``` carthage bootstrap --platform iOS ```

- Carthage is a dependency manager for external frameworks. The advantages of using Carthage instead of CocoaPods or embedded frameworks is that with Carthage you can just use a reference to your frameworks and avoid to have large files in the repository. It is completely compatible and supported.

## Authors & Contributors

** Aitor Pagan ** - *Initial work*

[Contributors](https://github.com/polenoso/who-is-this-gnome/graphs/contributors) who participated.

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

