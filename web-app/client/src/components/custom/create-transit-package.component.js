import React, { Component } from "react";
import axios from "axios";

export class CreateTransitPackage  extends Component {
  constructor(props) {
    super(props);

    this.onChangeIdentity =this.onChangeIdentity.bind(this)
    this.onChangeDepartureTime =this.onChangeDepartureTime.bind(this)
    this.onChangeArrivalTime =this.onChangeArrivalTime.bind(this)
    this.onChangeTypeOfStorage =this.onChangeTypeOfStorage.bind(this)
    this.onChangeDepLat = this.onChangeDepCoordinates.bind(this);
    this.onChangeDepLong = this.onChangeDepCoordinates.bind(this);
    this.onChangeArLat = this.onChangeDepCoordinates.bind(this);
    this.onChangeArLong = this.onChangeDepCoordinates.bind(this);
    this.onChangeDestCoordinates = this.onChangeDestCoordinates.bind(this);
    this.onChangeMeatMat = this.onChangeMeatMat.bind(this);
    this.onChangeStorageTime = this.onChangeStorageTime.bind(this);
    this.onChangeShippingMethod = this.onChangeShippingMethod.bind(this);
    this.onChangeFootprint = this.onChangeFootprint.bind(this);
    this.onChangeTransporterMat = this.onChangeTransporterMat.bind(this);
    this.onChangePackageReference = this.onChangePackageReference.bind(this);

    this.onSubmit = this.onSubmit.bind(this);

    this.state = {
      Identity: "",
      DepartureTime: "",
      ArrivalTime: "",
      TypeOfStorage: "",
      DepLat: "",
      DepLong: "",
      DestLat: "",
      DestLong: "",
      MeatMat: "",
      StorageTime: "",
      ShippingMethod: "",
      Footprint: "",
      TransporterMat: "",
      PackageReference: "",
    };
  }

  onChangeIdentity(e) {
    this.setState({
      Identity: e.target.value,
    });
  }

  onChangeDepartureTime(e) {
    this.setState({
      DepartureTime: e.target.value,
    });
  }
  onChangeArrivalTime(e) {
    this.setState({
      ArrivalTime: e.target.value,
    });
  }
  onChangeTypeOfStorage(e) {
    this.setState({
      TypeOfStorage: e.target.value,
    });
  }
  onChangeDepCoordinates(e) {
    this.setState({
      DepCoordinates: e.target.value,
    });
  }
  onChangeDestCoordinates(e) {
    this.setState({
      DestCoordinates: e.target.value,
    });
  }
  onChangeMeatMat(e) {
    this.setState({
      MeatMat: e.target.value,
    });
  }
  onChangeStorageTime(e) {
    this.setState({
      StorageTime: e.target.value,
    });
  }
  onChangeShippingMethod(e) {
    this.setState({
      ShippingMethod: e.target.value,
    });
  }
  onChangeFootprint(e) {
    this.setState({
      Footprint: e.target.value,
    });
  }
  onChangeTransporterMat(e) {
    this.setState({
      TransporterMat: e.target.value,
    });
  }
  onChangePackageReference(e) {
    this.setState({
      PackageReference: e.target.value,
    });
  }

  onSubmit(e) {
    e.preventDefault();

    const TransitPackage = {
      Identity: this.state.Identity,
      DepartureTime: this.state.DepartureTime,
      ArrivalTime: this.state.ArrivalTime,
      TypeOfStorage: this.state.TypeOfStorage,
      DepCoordinates: this.state.DepCoordinates,
      DestCoordinates: this.state.DestCoordinates,
      MeatMat: this.state.MeatMat,
      StorageTime: this.state.StorageTime,
      ShippingMethod: this.state.ShippingMethod,
      Footprint: this.state.Footprint,
      TransporterMat: this.state.TransporterMat,
      PackageReference: this.state.PackageReference,
    };

    axios
      .post("http://localhost:8090/transit/create", TransitPackage)
      .then((res) => console.log(res));
  }

  render() {
    return (
      <div>
        <h3>Create New Transit Package</h3>
        <form onSubmit={this.onSubmit}>
          <div className="form-group">
            <label>Identity: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.Identity}
              onChange={this.onChangeIdentity}
            />
          </div>
          <div className="form-group">
            <label>DepartureTime: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.DepartureTime}
              onChange={this.onChangeDepartureTime}
            />
          </div>
          <div className="form-group">
            <label>ArrivalTime: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.ArrivalTime}
              onChange={this.onChangeArrivalTime}
            />
          </div>
          <div className="form-group">
            <label>TypeOfStorage: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.TypeOfStorage}
              onChange={this.onChangeTypeOfStorage}
            />
          </div>
          <div className="form-group">
            <label>DepLat: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.DepLat}
              onChange={this.onChangeDepLat}
            />
          </div>
          <div className="form-group">
            <label>DepLong: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.DepLong}
              onChange={this.onChangeDepLong}
            />
          </div>
          <div className="form-group">
            <label>DesLat: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.DesLat}
              onChange={this.onChangeDesLat}
            />
          </div>
          <div className="form-group">
            <label>DestLong: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.DestLong}
              onChange={this.onChangeDestLong}
            />
          </div>
          <div className="form-group">
            <label>MeatMat: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.MeatMat}
              onChange={this.onChangeMeatMat}
            />
          </div>
          <div className="form-group">
            <label>StorageTime: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.StorageTime}
              onChange={this.onChangeStorageTime}
            />
          </div>
          <div className="form-group">
            <label>ShippingMethod: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.ShippingMethod}
              onChange={this.onChangeShippingMethod}
            />
          </div>
          <div className="form-group">
            <label>Footprint: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.Footprint}
              onChange={this.onChangeFootprint}
            />
          </div>
          <div className="form-group">
            <label>TransporterMat: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.TransporterMat}
              onChange={this.onChangeTransporterMat}
            />
          </div>
          <div className="form-group">
            <label>PackageReference: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.PackageReference}
              onChange={this.onChangePackageReference}
            />
          </div>
          <div className="form-group">
            <input
              type="submit"
              value="Create Transit Package"
              className="btn btn-primary"
            />
          </div>
        </form>
      </div>
    );
  }
}

export default CreateTransitPackage;
