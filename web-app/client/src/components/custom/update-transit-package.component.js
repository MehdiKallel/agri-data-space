import React, { Component } from "react";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import axios from "axios";

export class UpdateTransitPackage extends Component {
  constructor(props) {
    super(props);

    this.state = {
      DepartureTime: "",
      ArrivalTime: "",
      TypeOfStorage: "",
      DepCoordinates: "",
      DestCoordinates: "",
      MeatMat: "",
      StorageTime: "",
      ShippingMethod: "",
      Footprint: "",
      TransporterMat: "",
      PackageReference: "",
    };
  }

  componentDidMount() {
    axios.get("http://localhost:transitPackage/" + this.props.match.params.id)
    .then((response) => {
      this.setState({
        DepartureTime: response.data.DepartureTime,
        ArrivalTime: response.data.ArrivalTime,
        TypeOfStorage: response.data.TypeOfStorage,
        DepCoordinates: response.data.DepCoordinates,
        DestCoordinates: response.data.DestCoordinates,
        MeatMat: response.data.MeatMat,
        StorageTime: response.data.StorageTime,
        ShippingMethod: response.data.ShippingMethod,
        Footprint: response.data.Footprint,
        TransporterMat: response.data.TransporterMat,
        PackageReference: response.data.PackageReference,
      })
    })
  }

  onChangeDepartureTime(e) {
    this.setState({
      DepartureTime: e.target.value
    })
  }
  onChangeArrivalTime(e) {
    this.setState({
      ArrivalTime: e.target.value
    })
  }
  onChangeTypeOfStorage(e) {
    this.setState({
      TypeOfStorage: e.target.value
    })
  }
  onChangeDepCoordinates(e) {
    this.setState({
      DepCoordinates: e.target.value
    })
  }
  onChangeDestCoordinates(e) {
    this.setState({
      DestCoordinates: e.target.value
    })
  }
  onChangeMeatMat(e) {
    this.setState({
      MeatMat: e.target.value
    })
  }
  onChangeStorageTime(e) {
    this.setState({
      StorageTime: e.target.value
    })
  }
  onChangeShippingMethod(e) {
    this.setState({
      ShippingMethod: e.target.value
    })
  }
  onChangeFootprint(e) {
    this.setState({
      Footprint: e.target.value
    })
  }
  onChangeTransporterMat(e) {
    this.setState({
      TransporterMat: e.target.value
    })
  }
  onChangePackageReference(e) {
    this.setState({
      PackageReference: e.target.value
    })
  }

  onSubmit(e) {
    e.preventDefault();

    const transitPackage = {
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
    console.log(this.props.match);
    console.log(transitPackage);

    axios
    .post(
        "http://localhost:5000/transitPackage/update/" + this.props.match.params.id,
        transitPackage
    )
    .then((res) => console.log(res.data));

    window.location = "/ListTransitPackages";
  }

  // onChangeProductName(e) {
  //   this.setState({
  //     product_name: e.target.value,
  //   });
  // }
  //
  // onChangePrice(e) {
  //   this.setState({
  //     price: e.target.value,
  //   });
  // }
  //
  // onChangeManufacturerId(e) {
  //   this.setState({
  //     manufacturer_id: e.target.value,
  //   });
  // }
  //
  // onChangeManufacturerDate(date) {
  //   const newDate = { ...this.state.date, manufacturerDate: date };
  //   this.setState({ date: newDate });
  // }

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
              <label>DepCoordinates: </label>
              <input
                  type="text"
                  required
                  className="form-control"
                  value={this.state.DepCoordinates}
                  onChange={this.onChangeDepCoordinates}
              />
            </div>
            <div className="form-group">
              <label>DestCoordinates: </label>
              <input
                  type="text"
                  required
                  className="form-control"
                  value={this.state.DestCoordinates}
                  onChange={this.onChangeDestCoordinates}
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
                  type="datetime-local"
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
