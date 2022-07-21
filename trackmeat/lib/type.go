package lib

const (
	TransitPackageKey = "transitPackageReference"
	MeatKey           = "meatReference"
	UserKey           = "userKey"
)

type TransitPackage struct {
	ObjectType       string `json:"docType"`
	DepartureTime    string `json:"departureTime"`
	ArrivalTime      string `json:"arrivalTime"`
	TypeOfStorage    string `json:"typeOfStorage"`
	DepCoordinates   string `json:"depCoordinates"`
	DestCoordinates  string `json:"destCoordinates"`
	MeatMat          string `json:"meatMat"`
	StorageTime      int    `json:"storageTime"`
	ShippingMethod   string `json:"shippingMethod"`
	Footprint        string `json:"footprint"`
	TransporterMat   string `json:"transporterMat"`
	PackageReference string `json:"packageReference"`
}

type Meat struct {
	ObjectType      string `json:"docType"`
	MeatType        string `json:"meatType"`
	ShellLife       int `json:"shellLife"`
	ProcDate        string `json:"procDate"`
	FarmerMat       string `json:"farmerMat"`
	CountryOfOrigin string `json:"countryOfOrigin"`
	Footprint       string `json:"footprint"`
	MeatMat         string `json:"meatMat"`
}

type User struct {
	ObjectType string `json:"docType"`
	Name       string `json:"name"`
	Email      string `json:"email"`
	UserType   string `json:"userType"`
	Address    string `json:"address"`
	Identity   string `json:"identity"`
}
