# RESTfulRockTracks
A simple Universal iOS application that consumes an Apple RESTful web service and displays a list of rock tracks in a table view

Miro board created with initial plan of first screen. It demonstrates the focus placed on separation of concerns, clearly delineated app layers using Protocol-Oriented Programming (POP), and clean code:

https://miro.com/app/board/uXjVPb2W7NA=/?share_link_id=798538195872

Technologies and practices used:
- Git version control
- Jira-like ticketing in Git
- MVVM
- TDD
- Unit testing
- Coordinator pattern
- Dependency Injection
- Delegation
- Protocol-Oriented Programming
- Multi-layered App Architecture
- Dependency Inversion
- Clean Code
- Generics

## Layered Architecture

The app is separated into four layers: the Application, Presentation, Domain, and Data layers.

### Data Layer
The **Data Layer** is the lowest layer of the app, being the one that is least likely to change over time. It is responsible for fetching and storing data from data sources. This includes from APIs (e.g., over the Internet) and from local storage (e.g., a local cache).

The Data Layer currently contains two sub layers that, in a larger project, might be separated into their own discrete layers. These are the **Repositories** and the **Network**. The **Repository Layer** functions similar to a façade pattern, allowing objects in higher layers of the app to request data without caring where that data is coming from. The Repository Layer first attempts to find data in local storage (cache, such as NSCache or CoreData) and then attempts to find it from an external API (local network, Internet) if this is not possible.

The current version of the app does not implement a cache, so all requests must be made to the iTunes API. These requests are made through the **Network Layer**. The Network Layer has been designed to be flexible and request agnostic by making extensive use of protocols, dependency injection, and generics. With a few additional changes (e.g., better management of Decoder objects and the creation of dedicated Endpoints for each API service), the Network layer could be split into its own framework. Doing so would then let it be used not only in the app, but across various platforms to create a multi-product networking solution.

The more advanced version of the Network Layer, implemented in a separate private project, also includes logging functionality that prints network logs (requests/responses) to the XCode console. Further development of the Network Logger aims to also include this functionality in the app itself to provide diagnostic capabilities.

### Domain Layer

Above the Data Layer is the **Domain Layer**. This layer contains core app logic - for example, it contains Entities (e.g. SearchResult) that represent key app functionality. Repository Protocols are held in the Domain Layer, with their implementing classes in the Data Layer. This creates an inversion of dependencies at the layer-layer boundary, ensuring each layer can be tested and changed independently of the other. Changing one layer will only affect another if its public API (its interface) changes.

The Domain Layer also contains Use Cases - both their protocols and their implementing classes. The Use Cases in this app perform specific CRUD requests. Currently, only one Use Case (GetSearchResultsUseCase) is implemented, but the app is designed to easily allow others to expand upon existing CRUD functionality.

### Presentation Layer

The penultimate layer is the **Presentation Layer**. This layer is the most likely to change as it is the layer with which users interact with the app. It contains the UI and handles data modified for presentation. The Views, View Controllers, and View Models of MVVM sit in this layer. It interacts with the Domain Layer at the app boundary by View Models holding references to Use Case protocols. It therefore does not care about implementation of the Domain Layer, but instead interacts with the Domain Layer solely through the public API of these protocols. This ensures a clear separation.

View Models consume data from the Domain Layer and modify it for presentation in related View Controllers. They hold this modified data as publicly accessible variables, creating a single source of data in the Presentation Layer. Any changes to this data are shared to View Controllers through delegation - for example, when an asynchronous network request is completed and data has been fetched (or an error thrown that the user needs to be made aware of).

Any actions that must be taken by View Models are created in another layer - the Application Layer (see below). This allows dependency injection to be used not only for the mocking of referenced objects, but also for the behaviour of the System Under Test (SUT) itself.

### Application Layer

Sitting "above" and also "beside" the three main layers of the app, the **Application Layer** is the first to be created upon app startup. Holding the Coordinators of MVVM-C architecture and the Dependency-Injection Containers that hold many of the strong references present in the app, this layer exists to simplify the interaction of other layers and reduce their interdependency. By using an Application Layer, it is possible to increase app testability and extensibility at the expense of additional complexity.

## Future Changes

Some ideas for future improvements to the app include:
- Better handling of slow Internet speeds (show visual cues to user such as activity indicator, and present an error when requests time out).
- Better implement asynchronous programming, such as through the use of async/await.
- Remove force unwrapping where it has been temporarily used for haste.
- Expand tests to include View Models and other areas of the app that had TDD abandoned as a result of time constraints.
- Similarly: improve tests to account for multithreading.
- Improve UI and UX to make the app more appealing to use.
