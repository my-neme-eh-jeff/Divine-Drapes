import React, { useState } from "react";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";
import { Grid, IconButton } from "@mui/material";
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
import { useNavigate } from "react-router-dom";
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import Loader from './Loader/Loader'
export default function Myorders() {
  
    const navigate = useNavigate();
    const [like,setLike]=useState(0)
    const { auth, setAuth } = useAuth();
    const isLogin = auth?.accessToken;
    console.log(isLogin);
    const [favitem,setFavitem]=useState() 
    const addedssuccesully = () => {
      toast.success("Added succesfulyy", { containerId: "bottom-left" });
    };
  const removedsuccessfully = () => {
      toast.success("Removed", { containerId: "bottom-left" });
    };
  
    const delfromfav=(id)=>{

      let config = {
        method: 'delete',
        maxBodyLength: Infinity,
        url: 'https://divine-drapes.onrender.com/user/removeCart/'+id,
        headers: { 
          'Authorization': 'Bearer '+isLogin,
        }
      };
      console.log(config.url);

        async function makeRequest() {
          try {
            const response = await privateAxios.request(config);
            console.log((response.data));
            removedsuccessfully();
          }
          catch (error) {
            console.log(error);
          }
        }

        makeRequest();

    }
    const addtofav=(id)=>{
      console.log(id);
let config = {
  method: 'post',
  maxBodyLength: Infinity,
  url: 'https://divine-drapes.onrender.com/user/addCart/'+id,
  headers: { 
    'Authorization': 'Bearer '+isLogin,
  }
};

async function makeRequest() {
  try {
    const response = await privateAxios.request(config);
    console.log((response.data));
    addedssuccesully();
  }
  catch (error) {
    console.log(error);
  }
}

makeRequest();

    }
  
    useEffect(() => {

      let config = {
        method: "get",
        maxBodyLength: Infinity,
        url: 'https://divine-drapes.onrender.com/user/viewMyCart',
        headers: {
          Authorization:
            "Bearer "+isLogin,
        },
      };
  
      async function makeRequest() {
        try {
          const response = await privateAxios.request(config);
          console.log((response.data.data));
          const favData = response.data.data.map((item) => ({
            ...item,
            liked: true,
          }));
          setFavitem(favData);

        } catch (error) {
          console.log(error);
        }
      }
  
      makeRequest();
    }, []);
    const toggleLike1 = (id) => {
      setFavitem((prevFavitem) =>
        prevFavitem.map((item) => {
          if (item._id === id) {
            return { ...item, liked: !item.liked };
          }
          return item;
        })
      );
      delfromfav(id)
    }
    const toggleLike2 = (id) => {
      setFavitem((prevFavitem) =>
        prevFavitem.map((item) => {
          if (item._id === id) {
            return { ...item, liked: !item.liked };
          }
          return item;
        })
      );
      addtofav(id)
    }

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
            {favitem?<>
            {favitem.map((item)=>{
              console.log(item);
              return(
                <Grid item md={2.4} xs={12} sm={12} sx={{justifyContent:"center",display:"flex",alignItems:"center"}}>
              <Card sx={{ maxWidth: 250,"@media (min-width:700px)":{maxWidth:200} }}>
                <CardMedia
                  component="img"
                  alt="green iguana"
                  height="200"
                  image={item.photo.picture}
                  sx={{borderTopLeftRadius:"10px",borderTopRightRadius:"10px",borderBottomRightRadius:"10px",borderBottomLeftRadius:"10px"}}
                />
                <CardContent sx={{}}>
                  <Typography gutterBottom variant="h7" component="div" sx={{}}>
                    {item.name}
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    {item.description}
                  </Typography>
                </CardContent>
                <CardActions>
                  <Button
                  size="small" 
                  variant="contained" 
                  sx={{color:"white",backgroundColor:"#A01E86","&:hover": {backgroundColor: "#A01E86",border:2 }}}
                  onClick={()=>navigate('/product/:'+item._id)}
                  >View</Button>
                  
                  {item.liked ? (
            <IconButton sx={{ marginLeft: "5.5rem" }} onClick={() => toggleLike1(item._id)}>
              <FavoriteIcon sx={{ color: "red" }} />
            </IconButton>
          ) : (
            <IconButton sx={{ marginLeft: "5.5rem" }} onClick={() => toggleLike2(item._id)}>
              <FavoriteBorderIcon sx={{ color: "black" }} />
            </IconButton>
          )}
                  </CardActions>
              </Card>
            </Grid>
              )
            })}
            </>:<><Loader></Loader></>}
            
            
          </Grid>
        </Grid>
      </Grid>
      <ToastContainer position="bottom-left" />
    </>
  );
}
