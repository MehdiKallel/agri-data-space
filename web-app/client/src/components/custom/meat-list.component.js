import React, { Component } from "react";
import { Link } from "react-router-dom";
import axios from "axios";

const Meat = (props) => (
  <tr>
    <td>{props.meat.meatType}</td>
    <td>{props.meat.shellLife}</td>
    <td>{props.meat.procDate}</td>
    <td>{props.meat.countryOfOrigin}</td>
    <td>{props.meat.footprint}</td>
    <td>{props.meat.meatMat}</td>

    <td>
      <Link to={"/edit/" + props.meat._id}>Edit</Link>
    </td>
  </tr>
);

export class MeatList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      meat: [],
    };
  }

  componentDidMount() {
    axios
      .get("http://localhost:8090/meat/all")
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
          meat={currentMeat.Details}
          deleteMeat={this.deleteMeat}
          key={currentMeat.Org}
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
              <th>CountryOfOrigin</th>
              <th>Footprint</th>
              <th>MeatMat</th>
            </tr>
          </thead>
          <tbody>{this.MeatList()}</tbody>
        </table>
      </div>
    );
  }
}

export default MeatList;
