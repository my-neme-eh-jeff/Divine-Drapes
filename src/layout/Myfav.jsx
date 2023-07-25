import React, { useState } from "react";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";
import { Grid } from "@mui/material";
import Card from "@mui/material/Card";
import CardActions from "@mui/material/CardActions";
import CardContent from "@mui/material/CardContent";
import CardMedia from "@mui/material/CardMedia";
import Button from "@mui/material/Button";
import Typography from "@mui/material/Typography";
import { Link } from "react-router-dom";
import mug from '../images/coffee.png'
import FavoriteIcon from '@mui/icons-material/Favorite';
import FavoriteBorderIcon from '@mui/icons-material/FavoriteBorder';
import Footer from "./Footer/Footer";
import useAuth from "./../Hooks/useAuth";
import privateAxios from "./../Axios/privateAxios";
import { useEffect } from "react";
export default function Myorders() {
    const [like,setLike]=useState(0)
    const { auth, setAuth } = useAuth();
  const isLogin = auth?.accessToken;
  console.log(isLogin);
    useEffect(() => {

      let config = {
        method: "get",
        maxBodyLength: Infinity,
        url: 'https://divine-drapes.onrender.com/user/viewMyCart',
        headers: {
          Authorization:
            "Bearer " +isLogin,
        },
      };
  
      async function makeRequest() {
        try {
          const response = await privateAxios.request(config);
          console.log((response.data));
        } catch (error) {
          console.log(error);
        }
      }
  
      makeRequest();
    }, []);
  return (
    <>
      <Grid container>
        <Grid item md={0.5} xs={1}>
          <Link to="/profile">
            <ArrowBackIcon></ArrowBackIcon>
          </Link>
        </Grid>
        <Grid item md={11.5} xs={11}>
          <Grid container spacing={3}>
            <Grid item md={12} xs={12} sx={{ marginTop: "3px" }}>
              My Favourites
            </Grid>
            <Grid item md={2.4} xs={12} sm={12} sx={{justifyContent:"center",display:"flex",alignItems:"center"}}>
              <Card sx={{ maxWidth: 250,"@media (min-width:700px)":{maxWidth:200} }}>
                <CardMedia
                  component="img"
                  alt="green iguana"
                  height="200"
                  image={mug}
                  sx={{borderTopLeftRadius:"10px",borderTopRightRadius:"10px",borderBottomRightRadius:"10px",borderBottomLeftRadius:"10px"}}
                />
                <CardContent sx={{}}>
                  <Typography gutterBottom variant="h7" component="div" sx={{}}>
                    Mug
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    some decription...
                  </Typography>
                </CardContent>
                <CardActions>
                  <Button size="small" variant="contained" sx={{color:"white",backgroundColor:"#A01E86","&:hover": {backgroundColor: "#A01E86",border:2 }}}>View</Button>
                  
                  {(like==0)?<>
                    <FavoriteBorderIcon sx={{color:"red",marginLeft:"5.5rem"}}/>
                    </>:<>
                    <FavoriteBorderIcon sx={{color:"black",marginLeft:"5.5rem"}}/>
                    
                    </>}
                  </CardActions>
              </Card>
            </Grid>
            <Grid item md={2.4} xs={12} sm={12} sx={{justifyContent:"center",display:"flex",alignItems:"center"}}>
              <Card sx={{ maxWidth: 250,"@media (min-width:700px)":{maxWidth:200} }}>
                <CardMedia
                  component="img"
                  alt="green iguana"
                  height="200"
                  image={mug}
                  sx={{borderTopLeftRadius:"10px",borderTopRightRadius:"10px",borderBottomRightRadius:"10px",borderBottomLeftRadius:"10px"}}
                />
                <CardContent sx={{}}>
                  <Typography gutterBottom variant="h7" component="div" sx={{}}>
                    Mug
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    some decription...
                  </Typography>
                </CardContent>
                <CardActions>
                  <Button size="small" variant="contained" sx={{color:"white",backgroundColor:"#A01E86","&:hover": {backgroundColor: "#A01E86",border:2 }}}>View</Button>
                  <FavoriteIcon sx={{color:"red",marginLeft:"5.5rem"}}/>
                  </CardActions>
              </Card>
            </Grid>
            <Grid item md={2.4} xs={12} sm={12} sx={{justifyContent:"center",display:"flex",alignItems:"center"}}>
              <Card sx={{ maxWidth: 250,"@media (min-width:700px)":{maxWidth:200} }}>
                <CardMedia
                  component="img"
                  alt="green iguana"
                  height="200"
                  image={mug}
                  sx={{borderTopLeftRadius:"10px",borderTopRightRadius:"10px",borderBottomRightRadius:"10px",borderBottomLeftRadius:"10px"}}
                />
                <CardContent sx={{}}>
                  <Typography gutterBottom variant="h7" component="div" sx={{}}>
                    Mug
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    some decription...
                  </Typography>
                </CardContent>
                <CardActions>
                  <Button size="small" variant="contained" sx={{color:"white",backgroundColor:"#A01E86","&:hover": {backgroundColor: "#A01E86",border:2 }}}>View</Button>
                  <FavoriteIcon sx={{color:"red",marginLeft:"5.5rem"}}/>
                </CardActions>
              </Card>
            </Grid>
            <Grid item md={2.4} xs={12} sm={12} sx={{justifyContent:"center",display:"flex",alignItems:"center"}}>
              <Card sx={{ maxWidth: 250,"@media (min-width:700px)":{maxWidth:200} }}>
                <CardMedia
                  component="img"
                  alt="green iguana"
                  height="200"
                  image={mug}
                  sx={{borderTopLeftRadius:"10px",borderTopRightRadius:"10px",borderBottomRightRadius:"10px",borderBottomLeftRadius:"10px"}}
                />
                <CardContent sx={{}}>
                  <Typography gutterBottom variant="h7" component="div" sx={{}}>
                    Mug
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    some decription...
                  </Typography>
                </CardContent>
                <CardActions>
                  <Button size="small" variant="contained" sx={{color:"white",backgroundColor:"#A01E86","&:hover": {backgroundColor: "#A01E86",border:2 }}}>View</Button>
                  <FavoriteIcon sx={{color:"red",marginLeft:"5.5rem"}}/>
                  </CardActions>
              </Card>
            </Grid>
            <Grid item md={2.4} xs={12} sm={12} sx={{justifyContent:"center",display:"flex",alignItems:"center"}}>
              <Card sx={{ maxWidth: 250,"@media (min-width:700px)":{maxWidth:200} }}>
                <CardMedia
                  component="img"
                  alt="green iguana"
                  height="200"
                  image={mug}
                  sx={{borderTopLeftRadius:"10px",borderTopRightRadius:"10px",borderBottomRightRadius:"10px",borderBottomLeftRadius:"10px"}}
                />
                <CardContent sx={{}}>
                  <Typography gutterBottom variant="h7" component="div" sx={{}}>
                    Mug
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    some decription...
                  </Typography>
                </CardContent>
                <CardActions>
                  <Button size="small" variant="contained" sx={{color:"white",backgroundColor:"#A01E86","&:hover": {backgroundColor: "#A01E86",border:2 }}}>View</Button>
                  <FavoriteIcon sx={{color:"red",marginLeft:"5.5rem"}}/>
                  </CardActions>
              </Card>
            </Grid>
          </Grid>
        </Grid>
      </Grid>
    </>
  );
}
