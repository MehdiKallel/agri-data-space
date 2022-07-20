import React, { Component } from "react";
import { Link } from "react-router-dom";
import axios from "axios";

const TransitPackage = (props) => (
  <tr>

    <td>{props.transitPackage.DepartureTime}</td>
    <td>{props.transitPackage.ArrivalTime}</td>
    <td>{props.transitPackage.TypeOfStorage}</td>
    <td>{props.transitPackage.DepCoordinates}</td>
    <td>{props.transitPackage.DestCoordinates}</td>
    <td>{props.transitPackage.MeatMat}</td>
    <td>{props.transitPackage.StorageTime}</td>
    <td>{props.transitPackage.ShippingMethod}</td>
    <td>{props.transitPackage.Footprint}</td>
    <td>{props.transitPackage.TransporterMat}</td>
    <td>{props.transitPackage.PackageReference}</td>

    <td>
      <Link to={"/edit/" + props.transitPackage._id}>Edit</Link>
    </td>
  </tr>
);

export class TransitPackagesList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      role: sessionStorage.getItem('role'),
      transitPackages: [],
    };
  }

  componentDidMount() {
    const headers = {
      "x-access-token": sessionStorage.getItem("jwtToken"),
    };

    axios
      .get("http://192.168.0.108:8090/transitPackage/" + this.state.role, {
        headers: headers,
      })
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
            transitPackage={currentTransitPackage.Record}
          deleteTransitPackage={this.deleteTransitPackage}
          key={currentTransitPackage.Key}
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
              <th>TransporterMat</th>
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
