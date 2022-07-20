package main

import (
	"agriculture-space/my-network/chaincode/trackmeat/lib"
	"agriculture-space/my-network/chaincode/trackmeat/utils"
	"fmt"
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
	}
	fmt.Println("invoke did not find func: " + function) //error
	return shim.Error("Received unknown function invocation")
}

//method only used by farmer
func (t *SimpleChaincode) createUser(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	var err error

	if len(args) != 5 {
		return shim.Error("Incorrect number of arguments. Expecting 7")
	}
	for i, s := range args {
		if len(s) <= 0 {
			return shim.Error("argument " + strconv.Itoa(i) + " must be a non-empty string")
		}
	}
	msp, _ := cid.GetMSPID(stub)
	if msp != "FarmerOrgMSP" {
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

	if err := utils.WriteLedger(meat, stub, lib.MeatKey, []string{meat.MeatMat}); err != nil {
		return shim.Error(fmt.Sprintf("%s", err))
	}
	return shim.Success(nil)
}



//method only used by farmer
func (t *SimpleChaincode) registerMeat(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	var err error

	//   0       		1      		2      			3					4					5
	// "Type", "Processing date", "Shell life" 	"Meat mat"		Country of origin	"CO2 Footprint"
	if len(args) != 6 {
		return shim.Error("Incorrect number of arguments. Expecting 7")
	}
	for i, s := range args {
		if len(s) <= 0 {
			return shim.Error("argument " + strconv.Itoa(i) + " must be a non-empty string")
		}
	}
	msp, _ := cid.GetMSPID(stub)
	if msp != "FarmerOrgMSP" {
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

	if err := utils.WriteLedger(meat, stub, lib.MeatKey, []string{meat.MeatMat}); err != nil {
		return shim.Error(fmt.Sprintf("%s", err))
	}
	return shim.Success(nil)
}

//method only used by transporter
func (t *SimpleChaincode) transitMeat(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	var err error
	//   	0        	1      		2      			3					4								5				  6						7					8
	// "Dep time", 	"ar time", "type storage" 	"dep coordinates"	"destination coordinates"		"meat Mat"		"Storage time"		"Shipping method"		"CO2 Footprint"
	if len(args) != 10 {
		return shim.Error("Incorrect number of arguments. Expecting 7")
	}
	for i, s := range args {
		if len(s) <= 0 {
			return shim.Error("argument " + strconv.Itoa(i) + " must be a non-empty string")
		}
	}

	msp, _ := cid.GetMSPID(stub)
	if msp != "TransporterOrgMSP" {
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
	transit_package := lib.TransitPackage{TransporterMat: transporterMat, DepartureTime: depTime, ArrivalTime: arTime, TypeOfStorage: typeOfStorage, DepCoordinates: depCoordinates, DestCoordinates: destCoordinates, MeatMat: meatMat, StorageTime: storageTime, ShippingMethod: shippingMethod, Footprint: footprint, PackageReference: packageReference}
	if err := utils.WriteLedger(transit_package, stub, lib.TransitPackageKey, []string{transit_package.PackageReference}); err != nil {
		return shim.Error(fmt.Sprintf("%s", err))
	}
	return shim.Success(nil)
}
