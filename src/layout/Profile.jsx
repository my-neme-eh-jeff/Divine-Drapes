import React from 'react'
import { Grid, Paper,Button } from '@mui/material'
import pfp from '../images/pfp.jpg'
import EditIcon from '@mui/icons-material/Edit';
import { createTheme } from '@mui/material/styles';



export default function Profile() {
  const theme = createTheme();
  console.log(theme.breakpoints.up('md'));
  return (
    <div>
      <Grid container>
        <Grid item md={3} xs={12} sx={{backgroundColor:'white'}}>
          <Grid container>
            <Grid item md={3} xs={0}></Grid>
            <Grid item md={6} xs={12}>
            <img src={pfp} style={{borderRadius:'69px',width:"35%",[theme.breakpoints.up('md')]: {width: '83%','@media (minWidth:900px)': { width: '83%' } }}}></img>
            </Grid>
            <Grid item md={6} xs={12}>
            Full Name <Button><EditIcon sx={{marginTop:"2px"}}/></Button>
            </Grid>
            <Grid item md={3} xs={0}></Grid>
          </Grid>
        </Grid>
        <Grid item md={6} xs={12} sx={{backgroundColor:'white'}}>
            <Grid container rowSpacing={3}>
              <Grid item md={12} xs={12}></Grid>
              <Grid item md={12} xs={12}><Paper elevation={1} sx={{border:"solid 2px black",padding:"10px",borderRadius:"10px"}}>My orders</Paper></Grid>
              <Grid item md={12} xs={12}><Paper elevation={1} sx={{border:"solid 2px black",padding:"10px",borderRadius:"10px"}}>Favourites</Paper></Grid>
            </Grid>
        </Grid>
        <Grid item md={3} sx={{backgroundColor:"white"}}>

        </Grid>
      </Grid>
    </div>
  )
}
