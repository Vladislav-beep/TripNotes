//
//  Constants.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

struct C {
    
    enum ApiKeys: String {
        case weatherKey = "358389cc2e7b7f987ac85f1075b911c6"
    }
    
    enum URLs: String {
        case weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    }
    
    enum ImageNames: String {
        
        // MARK: Common
        case deleteIcon = "trash"
        case editIcon = "square.and.pencil"
        case tripPlaceHolder = "tripPlaceHolder"
        case heart = "heart.fill"
        
        // MARK: UI
        case back = "chevron.compact.left"
        case addressSearch = "magnifyingglass"
        
        // MARK: TabBar
        case tabBarTrip = "arrow.triangle.swap"
        
        // MARK: Trips
        case addTripButton = "plus"
        case signOutButton = "arrowshape.turn.up.left.2.fill"
        case weatherButton = "cloud.rain.fill"
        case mapButton = "map.fill"
        
        // MARK: Notes
        case hotel = "building.fill"
        case transport = "tram.tunnel.fill"
        case food = "hourglass.tophalf.fill"
        case activity = "camera.on.rectangle.fill"
        case purchases = "creditcard.fill"
        case other = "square.3.stack.3d.bottom.fill"
        case defaultCategory = "square"
        
        // MARK: NewTripViewController
        case country = "flag-edit"
        case calendar = "calendar-edit"
        case description = "pencil-edit"
        
        // MARK: NewNoteViewController
        case buildings = "buildings"
        case money = "money"
        
        // MARK: MapViewController
        case closeButton = "xmark.circle.fill"
        case showUserLocationButton = "location.circle"
        case mapPinImage = "mappin"
        
        // MARK: WeatherViewController
        case cloud = "cloud"
    }
    
    enum CellIdentifiers: String {
        case tripTableView = "tripTableViewCell"
        case noteCollectionView = "noteCollectionViewCell"
    }
}


struct I {
    
    // MARK: - Common
    static let defaultCurrency = "$"
    static let updateObserverName = "updateNotes"
    static let addNoteButtonTitle = "+ Add Note"
    
    static let errorAlertFetchingNotes = "Unable to fetch notes :( Try later!"
    static let errorConnectionAlertMessage = "Please, check your internet connection"
    static let errorConnectionAlertTitle = "Network error"
    static let locationManagerErrorAlertTitle = "Coudn't determine your location"
    
    static let emptyFieldsWarning = "None of fields can be empty"
    
    static let cameraActionSheet = "Camera"
    static let galleryActionSheet = "Gallery"
    static let placeHolderActionSheet = "Return placeholder"
    static let deleteActionSheet = "Delete image"
    static let cancelActionSheet = "Cancel"
    
    static let okButton = "OK"
    static let yes = "Yes"
    static let no = "No"
    
    
    
    // MARK: - UI
    static let welcomeLabelText = "Welcome to \n TripNotes"
    static let createButtonTitle = "Create new account"
    static let createLabelText = "I don't have an account"
    static let CreateNewAccountLabelText = "Create new account"
    static let addressButtonTitle = " Address"
    static let searchBarPlaceholder = "Search by description"
    
    
    
    // MARK: - AuthViewController
    static let emailTextFieldPlaceholder = "Email"
    static let passwordTextFieldPlaceholder = "Password"
    static let signInButtonTitle = "Sign in"
    static let incorrectWarning = "Incorrect email or password"
    
    
    
    // MARK: - NewAccountViewController
    static let nameTextFieldPlaceholder = "Name"
    static let signUpButtonTitle = "Sign up"
    static let haveLabelText = "Already have an account"
    static let logInButtonTitle = "Log in now"
    static let newAccountAlertTitle = "Empty fields"
    static let newAccountAlertPasswordTitle = "Wrong password"
    static let newAccountAlertPasswordMessage = "Password can't be less then 6 symbols"
    
    
    
    // MARK: - TabBar
    static let tabBarTripItemTitle = "Trips"
    static let tabBarFavItemTitle = "Favourites"
    
    
    
    // MARK: - TripsViewController
    static let noTripsLabel = "No Trips yet"
    static let editTripButtonTitle = "Edit Trip"
    static let deleteTripButtonTitle = "Delete"
    
    static let signOutAlertTitle = "Sign out?"
    static let signOutAlertMessage = "Do you realy want to sign out?"
    static let errorAlertFetchingTrips = "Unable to fetch trips :( Try later!"
    static let signOutAlertErrorTitle = "Could not sign out"
    static let signOutAlertErrorMessage = "Check your network connection"
    static let deleteTripAlertTitle = "Coudn't delete Trip("
    static let deleteTripAlertMessage = "Please, check your internet connection"
    
    // MARK: TripsViewModel
    static let sectionPlannedTitle = "Planned"
    static let sectionPastTitle = "Past trips"
    
    
    
    // MARK: - NotesViewController
    static let noNotesLabel = "No Notes yet"
    
    
    
    // MARK: - DetailNoteViewController
    static let deleteButtonTitle = " Delete"
    static let editButtonTitle = " Edit"
    
    
    
    // MARK: - FavouritesViewController
    static let noFavNotesLabel = "No favourite notes yet"
    
    // MARK: FavouritesViewModel
    static let hotelsScope = "H"
    static let transportScope = "T"
    static let foodScope = "F"
    static let activityScope = "A"
    static let purchasesScope = "P"
    static let otherScope = "O"
    static let allScope = "All"
    
    
    
    // MARK: - NewTripViewController
    static let countryTextFieldPlaceHolder = "Country"
    static let beginDateTextFieldPlaceHolder = "Date when trip begins"
    static let finishDateTextFieldPlaceHolder = "Date when trip ends"
    static let descriptionTextFieldPlaceHolder = "Describe your trip shortly"
    static let addNewTripButtonTitle = "+ Add Trip"
    static let currencyWarning = "Choose currency"
    static let dateWarning = "Beginning date can't be earlier then finishing date"
    static let updateTripAlertTitle = "Unable to update trip"
    static let addTripAlertTitle = "Unable to add trip"
    static let addNewTripEditButtonTitle = " Edit Trip"
    static let fetchTripAlertTitle = "Unable to fetch trip"
    
    
    
    // MARK: - NewNoteViewController
    static let categoryLabelText = "Category"
    static let cityLabelText = "City"
    static let cityTextFieldPlaceHolder = "Enter city"
    static let priceLabelText = "Price"
    static let priceTextFieldPlaceHolder = "Enter price"
    static let descriptionLabelText = "Description"
    static let countLabelText = "0/160"
    static let maxCharCount = "160"
    static let fetchNoteAlertTitle = "Unable to fetch note"
    static let fieldAndPriceWarning = "Fill all of fields or write correct price"
    static let categoryWarningText = "Choose category"
    static let updateNoteAlertTitle = "Unable to update note"
    static let addNOteAlertTitle = "Unable to add note"
    static let editNoteButtonTitle = " Edit Note"
    
    
    
    // MARK: - MapViewController
    static let restrictedAlertTitle = "Your location is restricted"
    static let restrictedAlertMessage = "To give permission go to: Settings -> My Places -> Location"
    static let deniedAlertTitle = "Your location is not available"
    static let deniedAlertMessage = "To give permission go to: Settings -> My Places -> Location"
}
