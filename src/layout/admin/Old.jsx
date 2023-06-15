import { Grid, Typography,Button } from '@mui/material'
import React from 'react'
import mug from "./coffee.png";

export default function 
() {
  return (
    <div>
        <Grid container>
          <Grid item md={10} sx={{backgroundColor:"white"}}>
            <Grid container>
              <Grid item md={2} sx={{}}>
                <img src={mug} style={{width:"60%",borderRadius:10}}/>
              </Grid>
              <Grid item md={4} >
                  <Typography variant='h5' sx={{fontWeight:4}}>M1 White mug</Typography>
                  <div style={{margin:20,border:"black solid 2px",borderRadius:5,marginRight:80,marginLeft:0,textAlign:"center"}}>Photo Attached</div>
              </Grid>
              <Grid item md={3}>
                  <Typography variant='h7' style={{marginBottom:25,fontSize:18}}>Payment:mode</Typography>
                  <div style={{marginTop:25,fontSize:18}}>Date:15/06/23</div>
              </Grid>
              <Grid item md={1} sx={{display:"flex",justifyContent:"center",alignItems:"center"}}>
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
              </Grid>
              <Grid item md={2}></Grid>
            </Grid>
          </Grid>
        </Grid>
    </div>
  )
}
