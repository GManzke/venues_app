# Near Venues

### Description
The Near Venues app integrates with the Wolt restaurant's API to display venues in proximity to the user's current location. It refreshes the list every 10 seconds, ensuring that any location changes are accounted for. Additionally, users have the option to tap on the "favorite" icon to mark a venue as a favorite.

| Video | Loading Screen | Error Screen |
| ------------- | ------------- | ----------- | 
|<img src="https://github.com/GManzke/venues_app/assets/52476927/4eb49279-33b0-4f01-a5d6-75a39a2b45db" width="300">| <img src="https://github.com/GManzke/venues_app/assets/52476927/933b0f5f-ad9b-4ead-a298-0e8f018c9235" width="300">|<img src="https://github.com/GManzke/venues_app/assets/52476927/91b467a6-482d-4ea1-898e-eea7173c5de2" width="300">|

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


## Final Considerations 

- This application, while compact in scope, is built upon a robust architectural foundation. The intention was to showcase proficiency in developing scalable systems. While Clean Architecture paired with Bloc for state management was chosen for this project, it's recognized that there's no one-size-fits-all solution in software development. Flexibility in adopting different architectural paradigms is crucial, as the best approach often varies based on specific use cases.
- Regardless of the specific architecture employed, having a well-defined structure is essential. It not only facilitates system scalability but also allows for team expansion, accommodating developers of varying expertise and seniority levels.
- Modularization is key for scalability. While the current structure centralizes functionalities within the "core" directory, it's better to split this into distinct modules to achieve a clearer separation of concerns. This not only streamlines code management but also simplifies future expansions.
  - Establishing a dedicated module for the design system, for instance, paves the way for integrating tools like Storybook. This facilitates developers in visualizing existing widgets, determining their reusability, and ensuring consistent UI components throughout the application.
  - Similarly, rather than housing services like Preferences Storage directly within the core, creating a distinct database module offers a more structured approach. This prevents the core from becoming a catch-all, ensuring that each service or functionality has a clear, designated location and imported only when needed.
