# Near Venues

### Description
The Near Venues app integrates with the Wolt restaurant's API to display venues in proximity to the user's current location. It refreshes the list every 10 seconds, ensuring that any location changes are accounted for. Additionally, users have the option to tap on the "favorite" icon to mark a venue as a favorite.

| Video | Loading Screen | Error Screen |
| ------------- | ------------- | ----------- | 
| PLACEHOLDER | PLACEHOLDER | PLACEHOLDER |

### Instalation

This project was made using **Flutter 3.13.9**

### Architecture

The diagram provided serves as a foundational blueprint for the app's development. As with any real-world project, it underwent iterative changes during development to cater to the evolving needs of the project. This diagram offers a holistic view of the app's architecture, which is rooted in the principles of Clean Architecture. The app is segmented into three primary layers:

- **Data Layer (Colored in Green)**:
  - Responsibilities: This layer is dedicated to managing data sources. It interfaces directly with the networking package for API requests, local preferences storage for persisting user favorite venues, and the geolocator service for fetching the current location.
  - Repository: It consolidates data from various sources and makes it accessible in a unified manner to the domain layer.

- **Domain Layer (Colored in Yellow)**:
  - Core Role: Encapsulates the business logic and core entities of the app.
  - Decoupling: In line with Clean Architecture principles, this layer operates independently, free from dependencies on external frameworks or libraries, ensuring flexibility and scalability.

- **Presentation Layer (Colored in Red)**:
  - UI Components: This layer houses all user interface elements.
  - Controller: Leveraging the bloc package, the Cubit controller in this layer manages state and interactions, bridging the UI with the underlying business logic.

This architectural design ensures a clear separation of concerns, enhancing maintainability, scalability, and testability of the app.

![venues_app_diagram](https://github.com/GManzke/venues_app/assets/52476927/d955c5e5-e0d8-4dd5-8ac0-3bff1ebe442d)

## Unit Testing

Unit testing is implemented using the **bloc_test** and **mocktail** packages. The Fixture technique is utilized to establish pre-defined states, facilitating the simulation of various scenarios to enhance the testing process.

Code coverage:
PLACEHOLDER


## Considerations 

- PLACEHOLDER
