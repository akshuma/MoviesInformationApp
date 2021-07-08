# MoviesInformationApp


Movie information App using open source api themoviedb.org.

# Architecture
This App is based upon Apple standard MVC Architecture, And code is arranged in following format:

HTTP Task: Common network layer  for  http call.
Route File: Common place to manage url route for all api's throught project.
Repository: Using this appraoch we can seemlessly integrate Dependency Injection for Unit test cases.
XcConfig: To manage configuration accross various environment ie: Dev, SIT, UAT etc.
CoreDataStack: Defined managedObject, persistence container and other core data configuration.


# Modules
For each feature we maintained different module and used storyboard and xib's to create UI.

Movie List: This module includes movie list.
Movie Details: This module includes synoypsis, credits details, users review and similar movies.
Users Reviews: This module includes customer review screen.
Movie Search: This module includes movie search and also support offline recent search using coredata.
Helper: This module includes Constants, UIKit and Foundation Kit extensions.


# Third party integration

This project is using cocoapods as package dependecy manager.

SDWebImage
Cosmos

# Unit test coverage (~ 60.4%)

Modules covered under unit test cases:
1. Environment
2. Movie List
3. Movie Detail
4. Users Review
5. Movie Search

