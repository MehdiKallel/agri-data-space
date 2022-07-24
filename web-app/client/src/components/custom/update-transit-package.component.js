import React, { Component } from "react";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import axios from "axios";

export class UpdateTransitPackage extends Component {
  constructor(props) {
    super(props);
    this.onChangeDepartureTime = this.onChangeDepartureTime.bind(this);
    this.onChangeArrivalTime = this.onChangeArrivalTime.bind(this);
    this.onChangeTypeOfStorage = this.onChangeTypeOfStorage.bind(this);
    this.onChangeDepLat = this.onChangeDepLat.bind(this);
    this.onChangeDepLong = this.onChangeDepLong.bind(this);
    this.onChangeDestLat = this.onChangeDestLat.bind(this);
    this.onChangeDestLong = this.onChangeDestLong.bind(this);
    this.onChangeStorageTime = this.onChangeStorageTime.bind(this);
    this.onChangeShippingMethod = this.onChangeShippingMethod.bind(this);
    this.onChangeFootprint = this.onChangeFootprint.bind(this);
    this.onChangeTransporterMat = this.onChangeFootprint.bind(this);
    this.onChangePackageReference = this.onChangePackageReference.bind(this);

    this.onSubmit = this.onSubmit.bind(this);

    this.state = {
      DepartureTime: "",
      ArrivalTime: "",
      TypeOfStorage: "",
      DepLat: "",
      DepLong: "",
      DestLat: "",
      DestLong: "",
      StorageTime: "",
      ShippingMethod: "",
      Footprint: "",
      TransporterMat: "",
      PackageReference: "",
    };
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

  onChangeDepLat(e) {
    this.setState({
      DepLat: e.target.value,
    });
  }
  onChangeDepLong(e) {
    this.setState({
      DepLong: e.target.value,
    });
  }

  onChangeDestLat(e) {
    this.setState({
      DestLat: e.target.value,
    });
  }
  onChangeDestLong(e) {
    this.setState({
      DestLong: e.target.value,
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

    const transitPackage = {
      DepartureTime: this.state.DepartureTime,
      ArrivalTime: this.state.ArrivalTime,
      TypeOfStorage: this.state.TypeOfStorage,
      DepLat: this.state.depLat,
      DepLong: this.state.depLong,
      DestLat: this.state.destLat,
      DestLong: this.state.destLong,
      MeatMat: this.state.MeatMat,
      StorageTime: this.state.StorageTime,
      ShippingMethod: this.state.ShippingMethod,
      Footprint: this.state.Footprint,
      TransporterMat: this.state.TransporterMat,
      PackageReference: this.state.PackageReference,
    };
    console.log(this.props.match);
    console.log(transitPackage);

    axios
      .post("http://localhost:5000/transit/update", transitPackage)
      .then((res) => console.log(res.data));

    window.location = "/ListTransitPackages";
  }

  render() {
    return (
      <div>
        <h3>Update Transit Package</h3>
        <form onSubmit={this.onSubmit}>
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
            <label>DestLat: </label>
            <input
              type="text"
              required
              className="form-control"
              value={this.state.DestLat}
              onChange={this.onChangeDestLat}
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
              value="Update Transit Package"
              className="btn btn-primary"
            />
          </div>
        </form>
      </div>
    );
  }
}

export default UpdateTransitPackage;
