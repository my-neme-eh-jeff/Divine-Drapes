import React from "react";
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

export default function Myorders() {
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
            <Grid item md={2.4} xs={12}>
              <Card sx={{ maxWidth: 200 }}>
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
                  <Button size="small" variant="outlined" sx={{borderColor:"#A01E86",color:"#A01E86",border:2,"&:hover": {backgroundColor: "white",borderColor:"#A01E86",border:2 }}}>Comment</Button>
                </CardActions>
              </Card>
            </Grid>
            <Grid item md={2.4} xs={12}>
              <Card sx={{ maxWidth: 200 }}>
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
                  <Button size="small" variant="outlined" sx={{borderColor:"#A01E86",color:"#A01E86",border:2,"&:hover": {backgroundColor: "white",borderColor:"#A01E86",border:2 }}}>Comment</Button>
                </CardActions>
              </Card>
            </Grid>
            <Grid item md={2.4} xs={12}>
              <Card sx={{ maxWidth: 200 }}>
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
                  <Button size="small" variant="outlined" sx={{borderColor:"#A01E86",color:"#A01E86",border:2,"&:hover": {backgroundColor: "white",borderColor:"#A01E86",border:2 }}}>Comment</Button>
                </CardActions>
              </Card>
            </Grid>
            <Grid item md={2.4} xs={12}>
              <Card sx={{ maxWidth: 200 }}>
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
                  <Button size="small" variant="outlined" sx={{borderColor:"#A01E86",color:"#A01E86",border:2,"&:hover": {backgroundColor: "white",borderColor:"#A01E86",border:2 }}}>Comment</Button>
                </CardActions>
              </Card>
            </Grid>
            <Grid item md={2.4} xs={12}>
              <Card sx={{ maxWidth: 200 }}>
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
                  <Button size="small" variant="outlined" sx={{borderColor:"#A01E86",color:"#A01E86",border:2,"&:hover": {backgroundColor: "white",borderColor:"#A01E86",border:2 }}}>Comment</Button>
                </CardActions>
              </Card>
            </Grid>
          </Grid>
        </Grid>
      </Grid>
    </>
  );
}
