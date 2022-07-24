import React from "react";
import { BrowserRouter as Router, Route } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.min.css";
import Navbar from "./components/default/navbar.component";
import CreateTransitPackage from "./components/custom/create-transit-package.component";
import CreateMeat from "./components/custom/create-meat.component";
import CreateUser from "./components/custom/create-user.component";
import MeatList from "./components/custom/meat-list.component";
import TransitPackageList from "./components/custom/transit-package-list.component";
import DeliverTransit from "./components/custom/deliver-transit.component";
import UpdateTransitPackage from "./components/custom/update-transit-package.component";

import UsersList from "./components/default/users-list.component";
import ProductsList from "./components/default/products-list.component";

function App() {
  const role = sessionStorage.getItem("role");
  console.log(role);
  return (
    <Router>
      <div className="container">
        <Navbar />
        <br />
        <Route path="/" exact component={CreateUser} />
        <Route path="/products" component={ProductsList} />
        <Route path="/createTransitPackage" component={CreateTransitPackage} />
        <Route path="/createUser" component={CreateUser} />
        <Route path="/createMeat" component={CreateMeat} />
        <Route path="/users" component={UsersList} />
        <Route path="/registerNewUser" component={CreateUser} />
        <Route path="/ListMeat" component={MeatList} />
        <Route path="/ListTransitPackages" component={TransitPackageList} />
        <Route path="/DeliverTransit" component={DeliverTransit} />
        <Route path="/UpdateTransitPackage" component={UpdateTransitPackage} />
      </div>
    </Router>
  );
}

export default App;
