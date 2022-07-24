import React, { Component } from "react";
import { Link } from "react-router-dom";
import axios from "axios";


const User = (props) => (
  <tr>
    <td>{props.user.name}</td>
    <td>{props.user.email}</td>
    <td>{props.user.userType}</td>
    <td>{props.user.address}</td>
    <td>{props.user.identity}</td>
  </tr>
);

export class UsersList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      users: [],
    };
  }

  componentDidMount() {
    axios
      .get("http://localhost:8090/user/all")
      .then((response) => {
        this.setState({
          users: response.data.data,
        });
      })
      .catch((error) => console.log(error));
  }

  usersList() {
    return this.state.users.map((currentUser) => {
      return (
        <User
          user={currentUser.Details}
          deleteUser={this.deleteUser}
          key={currentUser.Org}
        />
      );
    });
  }

  render() {
    return (
      <div>
        <h3>Users List</h3>
        <table className="table">
          <thead className="thead-light">
            <tr>
              <th>name</th>
              <th>email</th>
              <th>userType</th>
              <th>address</th>
              <th>identity</th>
            </tr>
          </thead>
          <tbody>{this.usersList()}</tbody>
        </table>
      </div>
    );
  }
}

export default UsersList;
