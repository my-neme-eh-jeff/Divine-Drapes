import { useState, useEffect } from 'react';
import Carousel from "react-multi-carousel";
import "react-multi-carousel/lib/styles.css";
import axios from 'axios'
import { Card, Button, Image, Stack, Heading, CardBody } from '@chakra-ui/react';

const responsive = {
  superLargeDesktop: {
    // the naming can be any, depends on you.
    breakpoint: { max: 4000, min: 1400 },
    items: 4
  },
  desktop: {
    breakpoint: { max: 1400, min: 1024 },
    items: 4
  },
  tablet: {
    breakpoint: { max: 1024, min: 464 },
    items: 3
  },
  mobile: {
    breakpoint: { max: 464, min: 0 },
    items: 1
  }
};

const TopSellingCarousel = () => {

    const [topSelling, setTopSelling] = useState([]);

    useEffect(() => {
        axios.get('https://dummyjson.com/posts')
        .then(res => setTopSelling(res.data.posts))
      },[])

    

  return (
    <>
    <Carousel responsive={responsive}
      removeArrowOnDeviceType={["tablet", "mobile"]}
      autoPlay={true}
      infinite={true}
      autoPlaySpeed={2000}>
            {topSelling?.map((item) => (
                    <Card maxW='sm' key={item}>
                    <CardBody>
                      <Image
                        src='https://images.unsplash.com/photo-1555041469-a586c61ea9bc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80'
                        alt='Green double couch with wooden legs'
                        borderRadius='lg'
                      />
                      <Stack mt='6' spacing='3'>
                        <Button><Heading size='md'>Item</Heading></Button>
                      </Stack>
                    </CardBody>
                  </Card>
                )               
            )} 
        </Carousel>
        </>
        

  )
}

export default TopSellingCarousel;


