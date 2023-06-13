import { useState, useEffect } from 'react'
import { Flex, 
    Text, 
    ChakraProvider, 
    SimpleGrid, 
    Card, CardHeader, Box, Avatar, Heading, GridItem
     } from '@chakra-ui/react';
import axios from 'axios';

const Testimonials = () => {
    const [testimonials, setTestimonials] = useState([]);

    useEffect(() => {
        axios.get('https://dummyjson.com/posts?limit=6')
        .then(res => setTestimonials(res.data.posts))
      },[])
    console.log(testimonials)
  return (
    <ChakraProvider>
      <SimpleGrid columns={{sm: 1, md: 3}} justifyContent='space-between' rowGap={3} columnGap={3} m='1.5% 0%'>
        {testimonials.map((index) => {
          return(
            <GridItem key={index}>
                <Card maxW='md' border='2px solid' borderRadius='10px'>
                  <CardHeader>
                    <Flex spacing='5'>
                      <Flex flex='1' gap='4' alignItems='center' flexWrap='wrap'>
                        <Avatar name='Segun Adebayo' src='https://bit.ly/sage-adebayo' />

                        <Box>
                          <Heading size='sm'>Jenny</Heading>
                          <Text>4.5</Text>
                        </Box>
                      </Flex>
                    </Flex>
                  </CardHeader>
                  <Flex m='0 0 10% 5%'>
                    <Text>
                      A wide variety of options, easy and lot of options in customization. Loved the products.
                    </Text>
                  </Flex>
                </Card>
            </GridItem>
        )})}
      </SimpleGrid>
    </ChakraProvider>
  )
}

export default Testimonials