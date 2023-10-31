# Near Venues

### Description
The Near Venues app integrates with the Wolt restaurant's API to present nearby venues based on the user's current location, along with the distance to each venue. The list is refreshed every 10 seconds to accommodate any changes in the user's location. Additionally, users can tap the "favorite" icon to add a venue to their list of favorites.

| Video | Refresh Animation | Loading Screen | Error Screen |
| ------------- | ------------- | ------------- | ----------- | 
|<img src="https://github.com/GManzke/venues_app/assets/52476927/95f60293-3eea-4949-811b-1d152d612e3d" width="200">| <img src="https://github.com/GManzke/venues_app/assets/52476927/78de717b-d4e4-44f3-a5cb-36f16e0b1e92" width="200"> |<img src="https://github.com/GManzke/venues_app/assets/52476927/60ebdce7-77dd-4ddb-85ca-49e01ef161cb" width="200">|<img src="https://github.com/GManzke/venues_app/assets/52476927/3b808838-ffc5-4f14-b271-140928607d10" width="200">|

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

![image](https://github.com/GManzke/venues_app/assets/52476927/010ddd95-a4aa-4501-b9f3-c8dad174e864)

## Final Considerations 

- This app showcases a scalable architecture, using Clean Architecture and Bloc for state management. While this was the chosen approach, it's important to be flexible and consider other paradigms as no single solution fits all projects.

- A clear structure is vital for scalability and supporting teams of varying skill levels.

- Future improvements could include modularizing the "core" directory into distinct units for better separation of concerns, such as creating dedicated modules for the design system and database functionalities. This would streamline the codebase and facilitate future expansions (e.g.: Storybook, Map of Dependencies).

- Although not included in this project, internationalization is an essential aspect that enhances user experience by catering to a global audience.
