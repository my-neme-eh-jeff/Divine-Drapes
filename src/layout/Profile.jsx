import { useEffect } from "react";
import { Grid, Paper, IconButton } from "@mui/material";
import pfp from "../images/pfp.jpg";
import ArrowForwardIcon from "@mui/icons-material/ArrowForward";
import "../styles/profile.css";
import { Link } from "react-router-dom";
import Footer from "./Footer/Footer";
import { useState } from "react";
import usePrivateAxios from "../Hooks/useAxiosPrivate";
import Avatar from '@mui/material/Avatar';
import Stack from '@mui/material/Stack';
import Navbar from "./Navbar/Navbar";
import Loader from "./Loader/Loader";
export default function Profile() {
  const [userdata, setUserdata] = useState();
  const privateAxios = usePrivateAxios();
  useEffect(() => {
    let config = {
      method: "GET",
      url: "user/profile",
    };
    async function makeRequest() {
      try {
        const response = await privateAxios.request(config);
        console.log(response.data.data);
        setUserdata(response.data);
      } catch (error) {
        console.log(error);
      }
    }
    makeRequest();
  }, []);

  return (
    <div>
      <Navbar/>
      {userdata ? (
        <>
          <Grid container sx={{paddingTop:10}}>
            <Grid item md={3} xs={12} sm={12} sx={{ backgroundColor: "white" }}>
              <Grid container>
                <Grid item md={3} xs={4} sm={4}></Grid>
                <Grid
                  item
                  md={6}
                  xs={4}
                  sm={4}
                  sx={{
                    justifyContent: "center",
                    display: "flex",
                    alignItems: "center",
                    marginTop: "20px",
                  }}
                >
                  <Avatar sx={{ width: 106, height: 106 }}>{userdata.data.fName[0]}</Avatar>
                </Grid>
                <Grid item md={3} xs={4} sm={4}></Grid>
                <Grid item md={3} xs={4} sm={4}></Grid>
                <Grid
                  item
                  md={6}
                  xs={4}
                  sm={4}
                  sx={{
                    display: "flex",
                    justifyContent: "center",
                    textAlign: "center",
                  }}
                >
                  {userdata.data.fName} {userdata.data.lName}
                </Grid>
                <Grid item md={3} xs={4} sm={4}></Grid>
              </Grid>
            </Grid>
            <Grid item md={6} xs={12} sm={12} sx={{ backgroundColor: "white" }}>
              <Grid container rowSpacing={3}>
                <Grid item md={12} xs={12} sm={12}>
                </Grid>
                <Grid item md={12} xs={12} sm={12} sx={{}}>
                  <Link to="/order">
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
                  <Link to="/fav">
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
            <Grid
              item
              md={3}
              xs={0}
              sm={0}
              sx={{ backgroundColor: "white" }}
            ></Grid>
          </Grid>
        </>
      ) : (
        <><Loader/></>
      )}

      <div style={{paddingTop:70}}>
        <Footer></Footer>
        </div>
    </div>
  );
}
