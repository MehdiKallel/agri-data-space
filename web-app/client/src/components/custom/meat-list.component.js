import React, { Component } from "react";
import { Link } from "react-router-dom";
import axios from "axios";

const Meat = (props) => (
  <tr>
    <td>{props.meat.MeatType}</td>
    <td>{props.meat.ShellLife}</td>
    <td>{props.meat.ProcDate}</td>
    <td>{props.meat.FarmerMat}</td>
    <td>{props.meat.CountryOfOrigin}</td>
    <td>{props.meat.Footprint}</td>
    <td>{props.meat.MeatMat}</td>

    {/*<td>{props.product.ProductID}</td>*/}
    {/*<td>{props.product.Name}</td>*/}
    {/*<td>{props.product.ManufacturerID}</td>*/}
    {/*<td>{props.product.Date.ManufactureDate.substring(0, 10)}</td>*/}
    {/*<td>{props.product.Status}</td>*/}
    {/*<td>{props.product.Price}</td>*/}
    <td>
      <Link to={"/edit/" + props.meat._id}>Edit</Link>
    </td>
  </tr>
);

export class MeatList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      role: sessionStorage.getItem('role'),
      meat: [],
    };
  }

  componentDidMount() {
    const headers = {
      "x-access-token": sessionStorage.getItem("jwtToken"),
    };

    axios
      .get("http://192.168.0.108:8090/meat/" + this.state.role, {
        headers: headers,
      })
      .then((response) => {
        this.setState({
          meat: response.data.data,
        });
      })
      .catch((error) => console.log(error));
  }

  MeatList() {
    return this.state.meat.map((currentMeat) => {
      return (
        <Meat
          meat={currentMeat.Record}
          deleteMeat={this.deleteMeat}
          key={currentMeat.Key}
        />
      );
    });
  }

  render() {
    return (
      <div>
        <h3>Meat List</h3>
        <table className="table">
          <thead className="thead-light">
            <tr>

              <th>MeatType</th>
              <th>ShellLife</th>
              <th>ProcDate</th>
              <th>FarmerMat</th>
              <th>CountryOfOrigin</th>
              <th>Footprint</th>
              <th>MeatMat</th>

              {/*<th>ProductId</th>*/}
              {/*<th>ProductName</th>*/}
              {/*<th>ManufacturerId</th>*/}
              {/*<th>ManufacturerDate</th>*/}
              {/*<th>Status</th>*/}
              {/*<th>Price</th>*/}
              {/*<th>Actions</th>*/}
            </tr>
          </thead>
          <tbody>{this.MeatList()}</tbody>
        </table>
      </div>
    );
  }
}

export default MeatList;
