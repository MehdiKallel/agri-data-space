import React, { Component } from "react";
import axios from "axios";

export class DeliverTransit extends Component {
  constructor(props) {
    super(props);

    this.onChangeTransitId = this.onChangeTransitId.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
    this.state = {
      transitId: "",
    };
  }

  onChangeTransitId(e) {
    this.setState({
      transitId: e.target.value,
    });
  }

  onSubmit(e) {
    const transit = {
      transitId: this.state.transitId,
    };
    axios
      .post("http://localhost:8090/transit/deliver", transit)
      .then((res) => console.log(res));
  }

  render() {
    return (
      <div>
        <h3>Transit package delivery</h3>
        <div className="form-group">
          <label>TransitId: </label>
          <input
            type="text"
            required
            className="form-control"
            value={this.state.transitId}
            onChange={this.onChangeTransitId}
          />
        </div>
        <form onSubmit={this.onSubmit}>
          <div className="form-group">
            <input
              type="submit"
              value="Register transit package delivery"
              className="btn btn-primary"
            />
          </div>
        </form>
      </div>
    );
  }
}

export default DeliverTransit ;
