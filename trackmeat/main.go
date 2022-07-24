package main

import (
	"agriculture-space/my-network/chaincode/trackmeat/lib"
	"agriculture-space/my-network/chaincode/trackmeat/utils"
	"bytes"
	"encoding/json"
	"fmt"
	"math"
	"strconv"
	"strings"

	"github.com/hyperledger/fabric-chaincode-go/pkg/cid"
	"github.com/hyperledger/fabric-chaincode-go/shim"
	pb "github.com/hyperledger/fabric-protos-go/peer"
)

type SimpleChaincode struct {
}

func main() {
	err := shim.Start(new(SimpleChaincode))
	if err != nil {
		fmt.Printf("Error starting Simple chaincode: %s", err)
	}
}

// Init initializes chaincode
// ===========================
func (t *SimpleChaincode) Init(stub shim.ChaincodeStubInterface) pb.Response {
	return shim.Success(nil)
}

// Invoke - Our entry point for Invocations
// ========================================
func (t *SimpleChaincode) Invoke(stub shim.ChaincodeStubInterface) pb.Response {

	function, args := stub.GetFunctionAndParameters()
	fmt.Println("invoke is running " + function)

	if function == "registerMeat" { //change owner of a specific marble
		return t.registerMeat(stub, args)
	} else if function == "transitMeat" {
		return t.transitMeat(stub, args)
	} else if function == "createUser" {
		return t.createUser(stub, args)
	} else if function == "queryUsers" {
		return t.queryUsers(stub)
	} else if function == "queryTransit" {
		return t.queryTransit(stub)
	} else if function == "queryMeat" {
		return t.queryMeat(stub)
	} else if function == "updateTransit" {
		return t.updateTransit(stub, args)
	} else if function == "deliverTransit" {
		return t.deliverTransit(stub, args)
	}
	fmt.Println("invoke did not find func: " + function) //error
	return shim.Error("Received unknown function invocation")
}
func (s *SimpleChaincode) queryUsers(APIstub shim.ChaincodeStubInterface) pb.Response {
	return s.getAllAssets(APIstub, lib.UserKey)
}

func (s *SimpleChaincode) queryMeat(APIstub shim.ChaincodeStubInterface) pb.Response {
	return s.getAllAssets(APIstub, lib.MeatKey)
}

func (s *SimpleChaincode) queryTransit(APIstub shim.ChaincodeStubInterface) pb.Response {
	return s.getAllAssets(APIstub, lib.TransitPackageKey)
}


func (s *SimpleChaincode) getAllAssets(APIstub shim.ChaincodeStubInterface, indexName string) pb.Response {

	allOrdersIterator, orgError := APIstub.GetStateByPartialCompositeKey(indexName, []string{})
	if orgError != nil {
		return shim.Error(orgError.Error())
	}
	defer allOrdersIterator.Close()

	var UserBuffer bytes.Buffer
	UserBuffer.WriteString("[")

	UserArrayMemberAlreadyWritten := false
	for allOrdersIterator.HasNext() {
		UserQueryResponse, orgError1 := allOrdersIterator.Next()
		if orgError1 != nil {
			return shim.Error(orgError1.Error())
		}

		if UserArrayMemberAlreadyWritten == true {
			UserBuffer.WriteString(",")
		}

		UserBuffer.WriteString("{\"Org\":")
		UserBuffer.WriteString("\"")
		_, orgKeyComp, orgKeyCompError := APIstub.SplitCompositeKey(UserQueryResponse.Key)
		if orgKeyCompError != nil {
			return shim.Error(orgKeyCompError.Error())
		}

		UserBuffer.WriteString(orgKeyComp[0])
		UserBuffer.WriteString("\"")

		UserBuffer.WriteString(", \"Details\":")
		UserBuffer.WriteString(string(UserQueryResponse.Value))
		UserBuffer.WriteString("}")
		UserArrayMemberAlreadyWritten = true
	}

	UserBuffer.WriteString("]")

	fmt.Printf(" - all Assets:\n%s\n", UserBuffer.String())
	return shim.Success(UserBuffer.Bytes())
}
//method only used by farmer
func (t *SimpleChaincode) createUser(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	if len(args) != 5 {
		return shim.Error("Incorrect number of arguments. Expecting 7")
	}
	for i, s := range args {
		if len(s) <= 0 {
			return shim.Error("argument " + strconv.Itoa(i) + " must be a non-empty string")
		}
	}
	name := args[0]
	email := strings.ToLower(args[1])
	userType := strings.ToLower(args[2])
	address := strings.ToLower(args[3])
	password := strings.ToLower(args[4])
	
	user := lib.User{Name: name, Email: email, UserType: userType, Address: address, Identity: password}

	objectBytes, errMarshal := json.Marshal(user)
	if errMarshal != nil {
		return shim.Error(fmt.Sprintf("Marshal Error in Product: %s", errMarshal))
	}

	if err := utils.WriteLedger(user, stub, lib.UserKey, []string{user.Name}); err != nil {
		return shim.Error(fmt.Sprintf("%s", err))
	}

	
	return shim.Success(objectBytes)
}



//method only used by farmer
func (t *SimpleChaincode) registerMeat(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	var err error

	//   0       		1      		2      			3					4					5
	// "Type", "Processing date", "Shell life" 	"Meat mat"		Country of origin	"CO2 Footprint"
	if len(args) != 7 {
		return shim.Error("Incorrect number of arguments. Expecting 7")
	}
	for i, s := range args {
		if len(s) <= 0 {
			return shim.Error("argument " + strconv.Itoa(i) + " must be a non-empty string")
		}
	}
	msp, _ := cid.GetMSPID(stub)
	if msp != "FarmerMSP" {
		return shim.Error("Only Farmers are allowed to register meat products")
	}
	meatType := args[0]
	procDate := strings.ToLower(args[1])
	shellLife, err := strconv.Atoi(args[2])
	if err != nil {
		return shim.Error("3rd argument must be a numeric string")
	}
	countryOfOrigin := strings.ToLower(args[4])
	footprint := strings.ToLower(args[5])
	meatMat := strings.ToLower(args[3])

	farmerMat, err := cid.GetID(stub)
	if err != nil {
		return shim.Error("Failed to get Farmer identity: " + err.Error())
	}

	meatAsBytes, err := stub.GetState(meatMat)
	if err != nil {
		return shim.Error("Failed to get meat: " + err.Error())
	} else if meatAsBytes != nil {
		fmt.Println("This meat already exists: " + meatMat)
		return shim.Error("This meat already exists: " + meatMat)
	}

	meat := lib.Meat{MeatType: meatType, ProcDate: procDate, ShellLife: shellLife, FarmerMat: farmerMat, CountryOfOrigin: countryOfOrigin, Footprint: footprint, MeatMat: meatMat}
	objectBytes, errMarshal := json.Marshal(meat)
	if errMarshal != nil {
		return shim.Error(fmt.Sprintf("Marshal Error in Product: %s", errMarshal))
	}
	if err := utils.WriteLedger(meat, stub, lib.MeatKey, []string{meat.MeatMat}); err != nil {
		return shim.Error(fmt.Sprintf("%s", err))
	}
	return shim.Success(objectBytes)
}

//method only used by transporter
func (t *SimpleChaincode) transitMeat(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	var err error
	//   	0        	1      		2      			3					4								5				  6						7					8
	// "Dep time", 	"ar time", "type storage" 	"dep coordinates"	"destination coordinates"		"meat Mat"		"Storage time"		"Shipping method"		"CO2 Footprint"
	if len(args) != 10 {
		return shim.Error("Incorrect number of arguments. Expecting 10")
	}
	for i, s := range args {
		if len(s) <= 0 {
			return shim.Error("argument " + strconv.Itoa(i) + " must be a non-empty string")
		}
	}

	msp, _ := cid.GetMSPID(stub)
	if msp != "TransporterMSP" {
		return shim.Error("Only transporters are allowed to create transit records")
	}

	depTime := args[0]
	arTime := strings.ToLower(args[1])
	typeOfStorage := strings.ToLower(args[2])
	depCoordinates := strings.ToLower(args[3])
	destCoordinates := strings.ToLower(args[4])
	meatMat := strings.ToLower(args[5])
	storageTime, err := strconv.Atoi(args[6])
	if err != nil {
		return shim.Error("7th argument must be a numeric string")
	}
	shippingMethod := strings.ToLower(args[7])
	footprint := strings.ToLower(args[8])
	packageReference := strings.ToLower(args[9])

	// ==== Getting transporter identity ====
	transporterMat, err := cid.GetID(stub)
	if err != nil {
		return shim.Error("Failed to get Transporter identity: " + err.Error())
	}

	results, err := utils.GetStateByPartialCompositeKeys(stub, lib.MeatKey, []string{meatMat})
	if err != nil || len(results) != 1 {
		return shim.Error(fmt.Sprintf("The meat reference verification failed %s", err))
	}
	// ==== Create package object ====
	transit_package := lib.TransitPackage{TransporterMat: transporterMat, DepartureTime: depTime, ArrivalTime: arTime, TypeOfStorage: typeOfStorage, DepCoordinates: depCoordinates, DestCoordinates: destCoordinates, MeatMat: meatMat, StorageTime: storageTime, ShippingMethod: shippingMethod, Footprint: footprint, PackageReference: packageReference, Status: "IN TRANSIT"}
	objectBytes, errMarshal := json.Marshal(transit_package)
	if errMarshal != nil {
		return shim.Error(fmt.Sprintf("Marshal Error in Product: %s", errMarshal))
	}
	if err := utils.WriteLedger(transit_package, stub, lib.TransitPackageKey, []string{transit_package.PackageReference}); err != nil {
		return shim.Error(fmt.Sprintf("%s", err))
	}
	return shim.Success(objectBytes)
}


func (t *SimpleChaincode) updateTransit(stub shim.ChaincodeStubInterface, args []string) pb.Response {

	lat1, err := strconv.ParseFloat(args[1], 64)
	if err != nil {
		return shim.Error("")
	}

	long1, err := strconv.ParseFloat(args[2], 64)
	if err != nil {
		return shim.Error("")
	}

	lat2, err := strconv.ParseFloat(args[3], 64)
	if err != nil {
		return shim.Error("")
	}

	long2, err := strconv.ParseFloat(args[4], 64)
	if err != nil {
		return shim.Error("")
	}

	radlat1 := float64(math.Pi * lat1 / 180)
	radlat2 := float64(math.Pi * lat2 / 180)
	
	theta := float64(long1 - long2)
	radtheta := float64(math.Pi * theta / 180)
	
	dist := math.Sin(radlat1) * math.Sin(radlat2) + math.Cos(radlat1) * math.Cos(radlat2) * math.Cos(radtheta);
	if dist > 1 {
		dist = 1
	}
	
	dist = math.Acos(dist)
	dist = dist * 180 / math.Pi
	dist = dist * 60 * 1.1515
	
	key, err := stub.CreateCompositeKey(lib.TransitPackageKey, []string{args[0]})
	if err != nil {
		return shim.Error(err.Error())
	}
	bytes, err := stub.GetState(key)

	transit := lib.TransitPackage{}
	if err != nil {
		return shim.Error("Failed to get Transit")
	}
	json.Unmarshal(bytes, &transit)
	footprint := transit.Footprint
	tmp, err:= strconv.ParseFloat(footprint,64)
	if err != nil {
		return shim.Error("")
	}
	transit.Footprint = fmt.Sprintf("%f", tmp+dist)
	transitAsBytes, _ := json.Marshal(transit)
	err2 := stub.PutState(key, transitAsBytes)

	if err2 != nil {
		return shim.Error("Failed to update transit State")
	}

	return shim.Success(transitAsBytes)
}

func (s *SimpleChaincode) deliverTransit(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	
	key, err := stub.CreateCompositeKey(lib.TransitPackageKey, []string{args[0]})
	if err != nil {
		return shim.Error(err.Error())
	}
	bytes, err := stub.GetState(key)

	transit := lib.TransitPackage{}
	if err != nil {
		return shim.Error("Failed to get Transit")
	}
	json.Unmarshal(bytes, &transit)
	transit.Status = "DELIVERED" 
	transitAsBytes, _:= json.Marshal(transit)
	err2 := stub.PutState(key, transitAsBytes)
	if err2 != nil {
		return shim.Error("Failed to update transit State")
	}

	return shim.Success(transitAsBytes)
}