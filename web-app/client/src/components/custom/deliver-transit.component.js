import React, { Component } from "react";
import axios from "axios";

export class DeliverTransit extends Component {
  constructor(props) {
    super(props);

    this.onChangeTransitId = this.onChangeTransitId.bind(this)

    this.onSubmit = this.onSubmit.bind(this);

    this.fields = ["transitId",]
    this.fieldTypes = {
    }

    this.fields.forEach(o => {
      if (this.fieldTypes[o] == null) {
        this.fieldTypes[o] = 'text'
      }
    })

    // this.onChangeFuncs = this.fields.map(o => {
    //   console.log("changingaaaa "+ o)
    //   const f = (e => {
    //     const nvm =new Map()
    //     nvm.set(o, e.target.value)
    //     this.setState(nvm);
    //     console.log("changing "+ o + " to " + e.target.value)
    //   })
    //   return [o, f.bind(this)]
    //   }
    // )

    // this.onChangeFuncs.forEach((v, k) => {
    //   this.onChangeFuncs[k] = v.bind(this)
    // })

    this.state = this.fields.map(o => [o, ""])

    // console.log(this.state2)


    // this.state = {
    //   MeatType: "",
    //   ShellLife: "",
    //   ProcDate: "",
    //   FarmerMat: "",
    //   CountryOfOrigin: "",
    //   Footprint: "",
    //   MeatMat: "",
    // };
    //
    // console.log(this.state)

  }

  onChangeTransitId(e) {
    this.setState({
      transitId: e.target.value,
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
      .post("http://192.168.0.108:8090/user/deliverTransit/" + this.state.role, meat, {
        headers: headers,
      })
      .then((res) => console.log(res));

    this.setState({
        user_id: meat.user_id,
    });

    // window.location = "/users";
  }

  render() {
    return (
      <div>
        <h3>Transit package delivery</h3>
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
