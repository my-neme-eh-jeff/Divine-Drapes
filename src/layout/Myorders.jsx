import React from "react";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";
import { Grid, Box, IconButton } from "@mui/material";
import Card from "@mui/material/Card";
import CardActions from "@mui/material/CardActions";
import CardContent from "@mui/material/CardContent";
import CardMedia from "@mui/material/CardMedia";
import Button from "@mui/material/Button";
import Typography from "@mui/material/Typography";
import { Link } from "react-router-dom";
import mug from "../images/coffee.png";
import Modal from "@mui/material/Modal";
import CloseIcon from "@mui/icons-material/Close";
import InputLabel from "@mui/material/InputLabel";
import MenuItem from "@mui/material/MenuItem";
import Select from "@mui/material/Select";
import useAuth from "./../Hooks/useAuth";
import privateAxios from "./../Axios/privateAxios";
import Footer from "./Footer/Footer";
import axios from "axios";
import { useEffect } from "react";
import { FormControl, TextareaAutosize } from "@mui/material";
import Rating from "@mui/material/Rating";
import { useNavigate } from "react-router-dom";
export default function Myorders() {
  const navigate = useNavigate();
  const [open, setOpen] = React.useState(false);
  const [rating, setRating] = React.useState(0);
  const [comment, setComment] = React.useState("");
  const [norders, setNorders] = React.useState();
  const [prodid, setProdid] = React.useState();
  const handleOpen = (id) => {
    console.log(id);
    setOpen(true);
    setProdid(id);
  };
  const handleClose = () => setOpen(false);
  const [age, setAge] = React.useState("");
  const { auth, setAuth } = useAuth();
  const isLogin = auth?.accessToken;
  const handleChange = (event) => {
    setAge(event.target.value);
  };

  const [pdetails, setPdetails] = React.useState([]);
  let details = [];
  useEffect(() => {
    let config = {
      method: "get",
      maxBodyLength: Infinity,
      url: "https://divine-drapes.onrender.com/user/viewOrder",
      headers: {
        Authorization: "Bearer " + isLogin,
      },
    };

    async function makeRequest() {
      try {
        const response = await privateAxios.request(config);
        console.log(response.data);
        setNorders(response.data.data);
        response.data.data.map((order) => {
          let config1 = {
            method: "get",
            maxBodyLength: Infinity,
            url: `https://divine-drapes.onrender.com/product/viewProduct/${order}`,
            headers: {
              "Content-Type": "application/json",
              Authorization: "Bearer " + isLogin,
            },
          };

          privateAxios
            .request(config1)
            .then((response) => {
              console.log(response.data.data);
              setPdetails((prevdata) => [...prevdata, response.data.data]);
              console.log(pdetails);
            })
            .catch((error) => {
              console.log(error);
            });
        });
      } catch (error) {
        console.log(error);
      }
    }

    makeRequest();
  }, []);

  const style = {
    position: "absolute",
    top: "50%",
    left: "50%",
    transform: "translate(-50%, -50%)",
    width: 400,
    bgcolor: "background.paper",
    border: "2px solid #000",
    boxShadow: 24,
    p: 4,
    borderRadius: 5,
  };
  const addcomment = () => {
    console.log(typeof(prodid));
    let data =JSON.stringify(
      {
      "productID" : prodid,
      "review" : comment,
      "star" : rating});

    let config = {
      method: "post",
      maxBodyLength: Infinity,
      url: "https://divine-drapes.onrender.com/user/createReview",
      headers: {
        Authorization:
          "Bearer " + isLogin,
        "Content-Type": "application/json",
      },
      data: data,
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
  };

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
              My Orders
            </Grid>
            {pdetails ? (
              <>
                {pdetails.map((order, k) => {
                  return (
                    <>
                      <Grid
                        item
                        md={2.4}
                        xs={12}
                        sm={12}
                        sx={{
                          justifyContent: "center",
                          display: "flex",
                          alignItems: "center",
                        }}
                      >
                        <Card
                          sx={{
                            maxWidth: 250,
                            "@media (min-width:700px)": { maxWidth: 200 },
                          }}
                          className="cards"
                        >
                          <CardMedia
                            component="img"
                            alt="green iguana"
                            height="200"
                            image={mug}
                            sx={{
                              borderTopLeftRadius: "10px",
                              borderTopRightRadius: "10px",
                              borderBottomRightRadius: "10px",
                              borderBottomLeftRadius: "10px",
                            }}
                          />
                          <CardContent sx={{}}>
                            <Typography
                              gutterBottom
                              variant="h7"
                              component="div"
                              sx={{}}
                            >
                              {order.name}
                            </Typography>
                            <Typography variant="body2" color="text.secondary">
                              {order.description}
                            </Typography>
                          </CardContent>
                          <CardActions>
                            <Button
                              size="small"
                              variant="contained"
                              sx={{
                                color: "white",
                                backgroundColor: "#A01E86",
                                "&:hover": {
                                  backgroundColor: "#A01E86",
                                  border: 2,
                                },
                              }}
                              onClick={() => {navigate(`/product/:${order._id}`)}}
                            >
                              View
                            </Button>
                            <Button
                              size="small"
                              variant="outlined"
                              onClick={() => handleOpen(order._id)}
                              sx={{
                                borderColor: "#A01E86",
                                color: "#A01E86",
                                border: 2,
                                "&:hover": {
                                  backgroundColor: "white",
                                  borderColor: "#A01E86",
                                  border: 2,
                                },
                              }}
                            >
                              Comment
                            </Button>
                          </CardActions>
                        </Card>
                      </Grid>
                    </>
                  );
                })}
              </>
            ) : (
              <></>
            )}
          </Grid>
        </Grid>
      </Grid>

      <Modal
        open={open}
        onClose={handleClose}
        aria-labelledby="modal-modal-title"
        aria-describedby="modal-modal-description"
      >
        <Box sx={style}>
          <Grid container rowSpacing={2}>
            <Grid item md={11} sx={{ marginTop: 1 }}>
              Add Comment
            </Grid>
            <Grid item md={1}>
              <IconButton onClick={handleClose}>
                <CloseIcon />
              </IconButton>
            </Grid>
            <Grid item md={2}>
              Rate:
            </Grid>
            <Grid item md={3}>
              <Rating
                name="half-rating"
                value={rating}
                onChange={(event) => {
                  setRating(event.target.value);
                }}
                precision={0.5}
              />
            </Grid>
            <Grid item md={7}></Grid>
            <br />
            <Grid item md={12}>
              <FormControl>
                <TextareaAutosize
                  value={comment}
                  onChange={(event) => {
                    setComment(event.target.value);
                  }}
                  minRows={5}
                  placeholder="Add Comment..."
                  style={{ width: "21rem", borderRadius: 10, padding: 3 }}
                />
              </FormControl>
            </Grid>
            <Grid item md={5}></Grid>
            <Grid item md={2}>
              <Button
                variant="contained"
                sx={{
                  color: "white",
                  backgroundColor: "#A01E86",
                  "&:hover": { backgroundColor: "#A01E86", border: 2 },
                }}
                onClick={addcomment}
              >
                ADD
              </Button>
            </Grid>
            <Grid item md={5}></Grid>
          </Grid>
        </Box>
      </Modal>
    </>
  );
}
