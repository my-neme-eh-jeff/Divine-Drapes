import { Grid, Avatar, Typography } from '@mui/material';
import { StarRate } from '@mui/icons-material';
import './Testimonials.css';

const Testimonials = () => {
  return (
    <div display='flex'>
      <Typography variant='h6' sx={{fontWeight: 'bold', mb: 2}}>Testimonials</Typography>
      <Grid container spacing={{ xs: 2, md: 3 }} columns={{ xs: 4, sm: 8, md: 12 }}>
        {Array.from(Array(6)).map((_, index) => (
          <Grid item xs={12} sm={4} md={4} key={index} >
            <div className='testimonial-card'>
              <div id='testimonial-profile'>
                <div>
                    <Avatar sx={{float: 'left', height: 60, width: 60}}>A</Avatar>
                    <div>
                        <Typography>Jenny</Typography>
                        <StarRate sx={{color: '#f7bc62', float: 'left'}} />
                        <Typography>4.5</Typography>
                    </div>
                </div>
                <div>
                    <Typography>
                        A wide variety of options, easy and lot of options in customization. Loved the products.
                    </Typography>
                </div>
              </div>
            </div>
          </Grid>
        ))}
      </Grid>
    </div>
  )
}

export default Testimonials