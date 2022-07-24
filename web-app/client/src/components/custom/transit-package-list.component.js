import React, { Component } from "react";
import { Link } from "react-router-dom";
import axios from "axios";

const TransitPackage = (props) => (
  <tr>
    <td>{props.transitPackage.departureTime}</td>
    <td>{props.transitPackage.arrivalTime}</td>
    <td>{props.transitPackage.typeOfStorage}</td>
    <td>{props.transitPackage.depCoordinates}</td>
    <td>{props.transitPackage.destCoordinates}</td>
    <td>{props.transitPackage.meatMat}</td>
    <td>{props.transitPackage.storageTime}</td>
    <td>{props.transitPackage.shippingMethod}</td>
    <td>{props.transitPackage.footprint}</td>
    <td>{props.transitPackage.packageReference}</td>

    <td>
      <Link to={"/edit/" + props.transitPackage._id}>Edit</Link>
    </td>
  </tr>
);

export class TransitPackagesList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      transitPackages: [],
    };
  }

  componentDidMount() {
    axios
      .get("http://localhost:8090/transit/all")
      .then((response) => {
        this.setState({
          transitPackages: response.data.data,
        });
      })
      .catch((error) => console.log(error));
  }

  transitPackagesList() {
    return this.state.transitPackages.map((currentTransitPackage) => {
      return (
        <TransitPackage
          transitPackage={currentTransitPackage.Details}
          deleteTransitPackage={this.deleteTransitPackage}
          key={currentTransitPackage.Org}
        />
      );
    });
  }

  render() {
    return (
      <div>
        <h3>Transit Packages List</h3>
        <table className="table">
          <thead className="thead-light">
            <tr>
              <th>DepartureTime</th>
              <th>ArrivalTime</th>
              <th>TypeOfStorage</th>
              <th>DepCoordinates</th>
              <th>DestCoordinates</th>
              <th>MeatMat</th>
              <th>StorageTime</th>
              <th>ShippingMethod</th>
              <th>Footprint</th>
              <th>PackageReference</th>
            </tr>
          </thead>
          <tbody>{this.transitPackagesList()}</tbody>
        </table>
      </div>
    );
  }
}

export default TransitPackagesList;
