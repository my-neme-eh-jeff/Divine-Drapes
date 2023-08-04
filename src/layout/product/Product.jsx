import React, { useEffect } from 'react'
import Content from './Content'
import { Box, ChakraProvider, Grid, Heading, SimpleGrid, Image, Text, Stack, Button } from '@chakra-ui/react'
import { Navigate } from 'react-router-dom'
import { useNavigate } from 'react-router-dom'
import Footer from '../Footer/Footer'
import Navbar from '../Navbar/Navbar'
import publicAxios from '../../Axios/publicAxios'
import privateAxios from '../../Axios/privateAxios';
import useAuth from '../../Hooks/useAuth';



function Product() {
    const nav = useNavigate();
    const buy = () => {
        console.log("buy now")
        nav('/buy')
    }
    const { auth, setAuth } = useAuth();
    const isLogin = auth?.accessToken;
    console.log(isLogin);

    const categoryProduct = async() => {
        let config = {
            method: 'get',
            // maxBodyLength: Infinity,
            // url: 'https://divine-drapes.onrender.com/product/categoryWise/Mugs',
            url: 'product/categoryWise/Mugs',
            headers: {
                'Authorization': 'Bearer ' + isLogin
            }
        };

        
        try{
            console.log(privateAxios)
            const response = await privateAxios.request(config)
            console.log(response.data)
        }
        catch(err){
            console.log(err)
        }
            // .then((response) => {
            //     console.log((response.data));
            // })
            // catch((error) => {
            //     console.log(error);
            // });

    }
    const getSingleProduct = () => {

        let config = {
            method: 'get',
            maxBodyLength: Infinity,
            url: 'https://divine-drapes.onrender.com/product/viewProduct/64c214b470ae96235c9e103f',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + isLogin
            },
        };

        privateAxios.request(config)
            .then((response) => {
                alert("hitted")
                console.log(JSON.stringify(response.data));
            })
            .catch((error) => {
                console.log(error);
            });

    }
    useEffect(
        () => {
            categoryProduct()
            getSingleProduct() 
        }, []
    )

    const addToCartAPI = () => {
        let config = {
            method: 'post',
            maxBodyLength: Infinity,
            url: 'https://divine-drapes.onrender.com/user/addCart/64c214b470ae96235c9e103f',
            headers: {
                'Authorization': 'Bearer ' + isLogin
            }
        };

        privateAxios.request(config)
            .then((response) => {
                console.log(JSON.stringify(response.data));
                alert("Added to card")
            })
            .catch((error) => {
                console.log(error);
                alert("Error")
            });
    }

    return (
        <div>
            <Navbar />
            <ChakraProvider>
                <Box className='productbody' >
                    <br />
                    {/* product name here  */}
                    <Heading className='namehere'>M1 White Mugs</Heading>
                    <br />
                    <Box height={'auto'} className='mainpro'>
                        <SimpleGrid
                            h='auto'

                            columns={{ base: 1, md: 3 }}
                            gap={15}

                        >
                            <Box className='Box'
                                display={'flex'}
                                justifyContent={'center'}
                                alignItems={'center'}
                                alignSelf={'center'}
                            >
                                <Image
                                    boxSize='280px'
                                    objectFit='cover'
                                    src='https://bit.ly/dan-abramov'
                                    alt='Dan Abramov'
                                />
                            </Box>
                            <Box className='Box'
                                display={'flex'}
                                justifyContent={'center'}
                                alignItems={'left'}
                                flexWrap={'center'}
                                flexDirection={'column'}>
                                <p><Heading fontSize={28} fontWeight={700}>M1 white mugs</Heading></p>
                                <p >Customizable with photo</p>
                                <br />
                                <p><Heading fontSize={24} fontWeight={700}>$150</Heading></p>
                                <br />
                                <Box>
                                    <Button backgroundColor={'#A01E86'} color={'white'}
                                        _hover={{
                                            backgroundColor: '#A01E86',
                                            color: 'black'
                                        }}
                                        onClick={buy}
                                    >Buy Now</Button>
                                    <Button
                                    marginLeft={'25px'}
                                    onClick={addToCartAPI}
                                    border={' 3px solid #A01E86'}
                                    >
                                        Add To Cart
                                    </Button>
                                </Box>

                            </Box>
                            <Box className='Box' id='rating'
                                display={'flex'} alignItems={'left'} fontSize={'18px'} fontWeight={700} >
                                <div className="content1">
                                    <div className="star" style={{ color: 'yellow' }}>
                                        <svg stroke="currentColor" fill="currentColor" stroke-width="0" version="1.1" viewBox="0 0 16 16" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M16 6.204l-5.528-0.803-2.472-5.009-2.472 5.009-5.528 0.803 4 3.899-0.944 5.505 4.944-2.599 4.944 2.599-0.944-5.505 4-3.899z"></path></svg>
                                    </div>
                                    <div className="rating" style={{ marginLeft: '8px' }}>4.5</div>
                                </div>
                            </Box>

                        </SimpleGrid>
                    </Box>


                    <br />
                    <Heading fontSize={'28px'} fontWeight={700} lineHeight={'38px'}>More Like This..</Heading>
                    <Box display={'flex'} flexWrap={'nowrap'} padding={'20px'} overflowX={'auto'}
                        className='recom'
                    >
                        <Content />
                        <Content />
                        <Content />
                        <Content />
                        <Content />
                        <Content />
                        <Content />
                        <Content />
                    </Box>
                </Box>
                <Footer />
            </ChakraProvider>
        </div >
    )
}

export default Product
