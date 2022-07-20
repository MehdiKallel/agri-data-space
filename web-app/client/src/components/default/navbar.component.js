import React, { Component } from "react";
import { Link } from "react-router-dom";

export class Navbar extends Component {
  render() {
    const role = sessionStorage.getItem("role");
    console.log(role);
    return (
      <nav className="navbar navbar-dark bg-dark navbar-expand-lg">
        <div className="navbar-brand">FoodSC</div>
        <div className="collapse navbar-collapse">
          <ul className="navbar-nav mr-auto">
            <li className="navbar-item">
              <Link to="/registerNewUser" className="nav-link">
                Register New User
              </Link>
            </li>
            <li className="navbar-item">
              <Link to="/createTransitPackage" className="nav-link">
                Create Transit Package
              </Link>
            </li>
            <li className="navbar-item">
              <Link to="/createMeat" className="nav-link">
                Register Meat
              </Link>
            </li>
            <li className="navbar-item">
              <Link to="/" className="nav-link">
                Logout
              </Link>
            </li>
          </ul>
        </div>
      </nav>
    );
  }
}

export default Navbar;
