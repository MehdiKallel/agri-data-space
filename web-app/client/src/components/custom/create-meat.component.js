import React, { Component } from "react";
import axios from "axios";

export class CreateMeat extends Component {
  constructor(props) {
    super(props);


    this.onChangeMeatType = this.onChangeMeatType.bind(this)
    this.onChangeShellLife = this.onChangeShellLife.bind(this)
    this.onChangeProcDate = this.onChangeProcDate.bind(this)
    this.onChangeFarmerMat = this.onChangeFarmerMat.bind(this)
    this.onChangeCountryOfOrigin = this.onChangeCountryOfOrigin.bind(this)
    this.onChangeFootprint = this.onChangeFootprint.bind(this)
    this.onChangeMeatMat = this.onChangeMeatMat.bind(this)

    this.onSubmit = this.onSubmit.bind(this);

    this.fields = [      "MeatType",  "ShellLife",  "ProcDate",  "FarmerMat",  "CountryOfOrigin",  "Footprint",  "MeatMat",]
    this.fieldTypes = {
      ShellLife: 'number'
    }

    this.fields.forEach(o => {
      if (this.fieldTypes[o] == null) {
        this.fieldTypes[o] = 'text'
      }
    })


    this.state = this.fields.map((o) => [o, ""]);


  }

  onChangeMeatType(e) {
    this.setState({
      MeatType: e.target.value,
    });
  }

  onChangeShellLife(e) {
    this.setState({
      ShellLife: e.target.value,
    });
  }
  onChangeProcDate(e) {
    this.setState({
      ProcDate: e.target.value,
    });
  }
  onChangeFarmerMat(e) {
    this.setState({
      FarmerMat: e.target.value,
    });
  }
  onChangeCountryOfOrigin(e) {
    this.setState({
      CountryOfOrigin: e.target.value,
    });
  }
  onChangeFootprint(e) {
    this.setState({
      Footprint: e.target.value,
    });
  }
  onChangeMeatMat(e) {
    this.setState({
      MeatMat: e.target.value,
    });
  }

  onSubmit(e) {
    e.preventDefault();

    const meat = this.fields.map(o => [o, this.state[o]])

    // const meat = {
    //   MeatType: this.state.MeatType,
    //   ShellLife: this.state.ShellLife,
    //   ProcDate: this.state.ProcDate,
    //   FarmerMat: this.state.FarmerMat,
    //   CountryOfOrigin: this.state.CountryOfOrigin,
    //   Footprint: this.state.Footprint,
    //   MeatMat: this.state.MeatMat,
    // };

    const headers = {
      "x-access-token": sessionStorage.getItem("jwtToken"),
    };

    console.log(meat);

    axios
      .post("http://localhost:8090/user/meat/" + this.state.role, meat, {
        headers: headers,
      })
      .then((res) => console.log(res));

    this.setState({
        user_id: meat.user_id,
    });

  }

  render() {
    return (
      <div>
        <h3>Register Meat</h3>
        <form onSubmit={this.onSubmit}>

            {this.fields.map(o =>
                <div className="form-group">
              <label>{o}: </label>
              <input
              type={this.fieldTypes[o]}
              required
              className="form-control"
              value={this.state[o]}
              onChange={this["onChange" + o]}
              />
              </div>
            )}
          {/*<div className="form-group">*/}
          {/*<label>MeatType: </label>*/}
          {/*  <input*/}
          {/*    type={this.fieldTypes["MeatType"]}*/}
          {/*    required*/}
          {/*    className="form-control"*/}
          {/*    value={this.state["MeatType"]}*/}
          {/*    onChange={this["onChangeMeatType"]}*/}
          {/*  />*/}
          {/*</div>*/}
          <div className="form-group">
            <input
              type="submit"
              value="Register Meat"
              className="btn btn-primary"
            />
          </div>
        </form>
      </div>
    );
  }
}

export default CreateMeat ;
