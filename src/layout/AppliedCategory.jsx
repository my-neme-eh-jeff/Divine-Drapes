import { ChakraProvider, GridItem, SimpleGrid, Flex, Stack, Heading, Text, Button, Image } from '@chakra-ui/react'
import { useState, useEffect } from 'react'
import axios from 'axios'
import Navbar from './Navbar/Navbar';
import { ArrowBackIcon } from '@chakra-ui/icons'
// import FavoriteBorderIcon from '@mui/icons-material/FavoriteBorder';
// import FavoriteIcon from '@mui/icons-material/Favorite';

const AppliedCategory = () => {
    const [products, setProducts] = useState([]);
    const [favIcon, setFavIcon] = useState(false)

    useEffect(() => {
        axios.get('https://dummyjson.com/posts?limit=8')
        .then(res => setProducts(res.data.posts))
      },[])

      const handleFavoriteClick = () => {
        setFavIcon(prevState => !prevState);
    };
  return (
    <ChakraProvider>
        <Navbar />
        <Heading pt='6%' ml='7%'><ArrowBackIcon /> Mugs</Heading>  
        <Flex justifyContent={'space-around'} m='3% 0'>
        <SimpleGrid columns={{sm: 1, md: 4}} rowGap={10} columnGap={20}>
        {products.map((index) => (
            <GridItem width={'250px'} key={index}>
                    <Image
                    src='https://images.unsplash.com/photo-1555041469-a586c61ea9bc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80'
                    alt='Green double couch with wooden legs'
                    borderRadius='lg'
                    width={'240px'}
                    height={'240px'}
                    alignSelf='center'
                    />
                    
                    <Flex justifyContent={'space-between'} mb='3%'>
                        <Stack mt='4' spacing=''>
                            <Heading size='md'>M1 White Mug</Heading>
                            <Text fontSize='sm' fontWeight={550}>
                                Customizable with photo
                            </Text>
                        </Stack>
                        <Stack mt='6' spacing='1' mr='3'>
                            <Text fontSize={'xl'} fontWeight='bold'>$150</Text>
                        </Stack>
                    </Flex>
                    <Flex justifyContent={'space-between'}>
                        <Button bgColor={"#f7bc62"} p='0 12%'>
                            Add to Cart
                        </Button>
                        {/* <Button bgColor={'white'} onClick={handleFavoriteClick}>
                                {!favIcon ? <FavoriteBorderIcon/> : <FavoriteIcon sx={{ color: 'red' }}/>}
                        </Button> */}
                    </Flex>
            </GridItem>
        ))}
        </SimpleGrid>                   
        </Flex>
    </ChakraProvider>
  )
}

export default AppliedCategory