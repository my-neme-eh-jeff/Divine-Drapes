import React from 'react'
import { useState } from 'react';
import Content from './Content'
import { Box, ChakraProvider, Grid, Heading, SimpleGrid, Image, Text, Stack, Button } from '@chakra-ui/react'


function Buy() {
    const [selectedImage, setSelectedImage] = useState(null);

    const handleImageChange = (event) => {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = () => {
                setSelectedImage(reader.result);
            };
            reader.readAsDataURL(file);
        }
        console.log(selectedImage)
    };
    return (
        <div>
            <ChakraProvider>
                <Box className='productbody' >
                    <br />
                    {/* product name here  */}
                    <Heading>M1 White Mugs</Heading>
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
                            backgroundColor={'yellow'}
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
                                <div>
                                    <input type="file" accept="image/*" placeholder='Upload your customization' onChange={handleImageChange} />
                                    {selectedImage && <img src={selectedImage} alt="Preview" />}
                                </div>
                                <br />
                                <Box display={'flex'} justifyContent={'space-around'} width={'auto'} >
                                    <Button>Shipping Address</Button>
                                    <Button>Payment Option</Button>
                                </Box>
                                <br />
                                <Box textAlign={'center'} justifyContent={'center'} backgroundColor={'pink'} display={'flex'}>
                                    <Button backgroundColor={'#A01E86'} color={'white'}
                                        _hover={{
                                            backgroundColor: '#A01E86',
                                            color: 'black'
                                        }}
                                        display={'flex'}
                                        justifyContent={'center'}
                                    >Buy Now</Button>
                                </Box>

                                <Box className='Box'>

                                </Box>

                            </Box>

                        </SimpleGrid>
                    </Box>
                </Box>
            </ChakraProvider>
        </div >
    )
}

export default Buy
