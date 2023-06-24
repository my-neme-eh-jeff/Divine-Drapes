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

import { FormControl, TextareaAutosize } from "@mui/material";

export default function Myorders() {
  const [open, setOpen] = React.useState(false);
  const handleOpen = () => setOpen(true);
  const handleClose = () => setOpen(false);
  const [age, setAge] = React.useState("");

  const handleChange = (event) => {
    setAge(event.target.value);
  };

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
            <Grid item md={2.4} xs={12} sm={12} sx={{justifyContent:"center",display:"flex",alignItems:"center"}}>
              <Card sx={{ maxWidth: 250,"@media (min-width:700px)":{maxWidth:200} }} className="cards">
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
                  <Typography gutterBottom variant="h7" component="div" sx={{}}>
                    Mug
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    some decription...
                  </Typography>
                </CardContent>
                <CardActions>
                  <Button
                    size="small"
                    variant="contained"
                    sx={{
                      color: "white",
                      backgroundColor: "#A01E86",
                      "&:hover": { backgroundColor: "#A01E86", border: 2 },
                    }}
                  >
                    View
                  </Button>
                  <Button
                    size="small"
                    variant="outlined"
                    onClick={handleOpen}
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
            <Grid item md={2.4} xs={12} sm={12} sx={{justifyContent:"center",display:"flex",alignItems:"center"}}>
              <Card sx={{ maxWidth: 250,"@media (min-width:700px)":{maxWidth:200} }}>
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
                  <Typography gutterBottom variant="h7" component="div" sx={{}}>
                    Mug
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    some decription...
                  </Typography>
                </CardContent>
                <CardActions>
                  <Button
                    size="small"
                    variant="contained"
                    sx={{
                      color: "white",
                      backgroundColor: "#A01E86",
                      "&:hover": { backgroundColor: "#A01E86", border: 2 },
                    }}
                  >
                    View
                  </Button>
                  <Button
                    size="small"
                    variant="outlined"
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
            <Grid item md={2.4} xs={12} sm={12} sx={{justifyContent:"center",display:"flex",alignItems:"center"}}>
              <Card sx={{ maxWidth: 250,"@media (min-width:700px)":{maxWidth:200} }}>
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
                  <Typography gutterBottom variant="h7" component="div" sx={{}}>
                    Mug
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    some decription...
                  </Typography>
                </CardContent>
                <CardActions>
                  <Button
                    size="small"
                    variant="contained"
                    sx={{
                      color: "white",
                      backgroundColor: "#A01E86",
                      "&:hover": { backgroundColor: "#A01E86", border: 2 },
                    }}
                  >
                    View
                  </Button>
                  <Button
                    size="small"
                    variant="outlined"
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
            <Grid item md={2.4} xs={12} sm={12} sx={{justifyContent:"center",display:"flex",alignItems:"center"}}>
              <Card sx={{ maxWidth: 250,"@media (min-width:700px)":{maxWidth:200} }}>
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
                  <Typography gutterBottom variant="h7" component="div" sx={{}}>
                    Mug
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    some decription...
                  </Typography>
                </CardContent>
                <CardActions>
                  <Button
                    size="small"
                    variant="contained"
                    sx={{
                      color: "white",
                      backgroundColor: "#A01E86",
                      "&:hover": { backgroundColor: "#A01E86", border: 2 },
                    }}
                  >
                    View
                  </Button>
                  <Button
                    size="small"
                    variant="outlined"
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
              Stars
            </Grid>
            <Grid item md={3}>
              <Box sx={{ minWidth: 50 }}>
                <FormControl fullWidth>
                  <InputLabel id="demo-simple-select-label">Stars</InputLabel>
                  <Select
                    labelId="demo-simple-select-label"
                    id="demo-simple-select"
                    value={age}
                    label="Age"
                    onChange={handleChange}
                  >
                    <MenuItem value={1}>1</MenuItem>
                    <MenuItem value={2}>2</MenuItem>
                    <MenuItem value={3}>3</MenuItem>
                    <MenuItem value={4}>4</MenuItem>
                    <MenuItem value={5}>5</MenuItem>
                  </Select>
                </FormControl>
              </Box>
            </Grid>
            <Grid item md={7}></Grid>
            <br />
            <Grid item md={12}>
              <FormControl>
                <TextareaAutosize
                  minRows={5}
                  placeholder="Add Comment..."
                  style={{ width: "21rem", borderRadius: 10 }}
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