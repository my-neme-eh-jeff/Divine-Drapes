import React from "react";
import { Grid, Paper, Button, IconButton } from "@mui/material";
import pfp from "../images/pfp.jpg";
import EditIcon from "@mui/icons-material/Edit";
import { createTheme } from "@mui/material/styles";
import ArrowForwardIcon from "@mui/icons-material/ArrowForward";
import "../styles/profile.css";
import { Link } from "react-router-dom";
import Footer from "./Footer/Footer";

export default function Profile() {
  const theme = createTheme();
  console.log(theme.breakpoints.up("md"));
  return (
    <div>
      <Grid container>
        <Grid item md={3} xs={12} sm={12} sx={{ backgroundColor: "white" }}>
          <Grid container >
            <Grid item md={3} xs={4} sm={4}></Grid>
            <Grid item md={6} xs={4} sm={4} sx={{justifyContent:"center",display:"flex",alignItems:"center"}}>
              <img
                src={pfp}
                className="image"
                
              ></img>
            </Grid>
            <Grid item md={3} xs={4} sm={4}></Grid>
            <Grid item md={3} xs={4} sm={4}></Grid>
            <Grid item md={6} xs={4} sm={4} sx={{display:"flex",justifyContent:"center",textAlign:"center"}}>
              Full Name
            </Grid>
            <Grid item md={3} xs={4} sm={4}></Grid>
          </Grid>
        </Grid>
        <Grid item md={6} xs={12} sm={12} sx={{ backgroundColor: "white" }}>
          <Grid container rowSpacing={3}>
            <Grid item md={12} xs={12} sm={12}> </Grid>
            <Grid item md={12} xs={12} sm={12}>
              <Link to='/order'>
              <Paper
                elevation={1}
                sx={{
                  border: "solid 2px black",
                  padding: "10px",
                  borderRadius: "10px",
                }}
              >
                My orders
                <div className="icons1" style={{ display: "inline" }}>
                  <IconButton>
                    <ArrowForwardIcon />
                  </IconButton>
                </div>
              </Paper>
              </Link>
            </Grid>
            <Grid item md={12} xs={12} sm={12}>
              <Link to='/fav'>
              <Paper
                elevation={1}
                sx={{
                  border: "solid 2px black",
                  padding: "10px",
                  borderRadius: "10px",
                }}
              >
                Favourites
                <div className="icons2" style={{ display: "inline" }}>
                  <IconButton>
                    <ArrowForwardIcon />
                  </IconButton>
                </div>
              </Paper>
              </Link>
            </Grid>
          </Grid>
        </Grid>
        <Grid item md={3} xs={0} sm={0} sx={{ backgroundColor: "white" }}></Grid>
      </Grid>
      <div className="footer">
      <Footer></Footer>
      </div>
      
    </div>
  );
}