import React, { Component } from "react";
import { Link } from "react-router-dom";
import axios from "axios";


const User = (props) => (
  <tr>
    <td>{props.user.name}</td>
    <td>{props.user.userType}</td>
    <td>{props.user.address}</td>
    <td>{props.user.password}</td>
  </tr>
);

export class UsersList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      role: "",
      users: [],
    };
  }

  componentDidMount() {
    axios
      .get("http://localhost:8090/user/all")
      .then((response) => {
        return response.data.data;
      })
      .catch((error) => console.log(error));
  }

  usersList() {
    return this.state.users.map((currentUser) => {
      return (
        <User
          user={currentUser.Record}
          deleteUser={this.deleteUser}
          key={currentUser.Key}
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
              <th>email</th>
              <th>userType</th>
              <th>address</th>
              <th>password</th>
            </tr>
          </thead>
          <tbody>{this.usersList()}</tbody>
        </table>
      </div>
    );
  }
}

export default UsersList;
