import React, { Component } from "react";
import axios from "axios";

export class CreateUser extends Component {
  constructor(props) {
    super(props);
    this.onChangeName = this.onChangeName.bind(this);
    this.onChangePassword = this.onChangePassword.bind(this);
    this.onChangeEmail = this.onChangeEmail.bind(this);
    this.onChangeUsertype = this.onChangeUsertype.bind(this);
    this.onChangeAddress = this.onChangeAddress.bind(this);
    this.onSubmit = this.onSubmit.bind(this);

    this.state = {
      name: "",
      email: "",
      userType: "",
      address: "",
      password: "",
      role: "",
    };
  }

  onChangeName(e) {
    this.setState({
      name: e.target.value,
    });
  }

  onChangePassword(e) {
    this.setState({
      password: e.target.value,
    });
  }

  onChangeEmail(e) {
    this.setState({
      email: e.target.value,
    });
  }

  onChangeUsertype(e) {
    if (e.target.value === "farmer") {
      this.setState({
        role: "farmer",
      });
    } else if (e.target.value === "auditor") {
      this.setState({
        role: "auditor",
      });
    } else if (e.target.value === "transporter") {
      this.setState({
        role: "transporter",
      });
    }
    this.setState({
      userType: e.target.value,
    });
    console.log(this.state.userType);
  }

  onChangeAddress(e) {
    this.setState({
      address: e.target.value,
    });
  }

  onSubmit(e) {
    e.preventDefault();

    const user = {
      name: this.state.name,
      email: this.state.email,
      userType: this.state.userType,
      address: this.state.address,
      password: this.state.password,
    };

    const headers = {
      "x-access-token": sessionStorage.getItem("jwtToken"),
    };

    console.log(user);

    axios
      .post("http://localhost:8090/user/signup/" + this.state.userType, user, {
        headers: headers,
      })
      .then((res) => console.log(res));

    this.setState({
      user_id: user.user_id,
    });

    window.location = "/users";
  }

  render() {
    return (
      <div>
        <h3>Register New User</h3>
        <form onSubmit={this.onSubmit}>
          <div className="form-group">
            <label>Name: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.name}
              onChange={this.onChangeName}
            />
          </div>
          <div className="form-group">
            <label>Password: </label>
            <input
              type="password"
              required
              className="form-control"
              value={this.state.password}
              onChange={this.onChangePassword}
            />
          </div>
          <div className="form-group">
            <label>Email: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.email}
              onChange={this.onChangeEmail}
            />
          </div>
          <div className="form-group">
            <label>Usertype: </label>
            <select
              ref="usertypeInput"
              required
              className="form-control"
              value={this.state.userType}
              onChange={this.onChangeUsertype}
            >
              <option key="farmer" value="farmer">
                Farmer
              </option>
              <option key="auditor" value="auditor">
                Auditor
              </option>
              <option key="transporter" value="transporter">
                Transporter
              </option>
            </select>
          </div>
          <div className="form-group">
            <label>Address: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.address}
              onChange={this.onChangeAddress}
            />
          </div>
          <div className="form-group">
            <input
              type="submit"
              value="Register User"
              className="btn btn-primary"
            />
          </div>
        </form>
      </div>
    );
  }
}

export default CreateUser;
