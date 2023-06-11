import React from 'react'
import { useState } from 'react';
import { Box, ChakraProvider, Heading, SimpleGrid, Image, Button, Select } from '@chakra-ui/react'
import './Upload.css'
import Footer from '../Footer/Footer';


function Buy() {
    const [selectedImage, setSelectedImage] = useState(null);
    const [pay, setPay] = useState()


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
                                <div className="image-uploader">
                                    <label htmlFor="upload-input" className="upload-label">
                                        <span className="upload-text">Upload your customization</span>
                                        <input id="upload-input" type="file" accept="image/*" onChange={handleImageChange} />
                                    </label>
                                    {selectedImage && <img src={selectedImage} alt="Preview" className="preview-image" />}
                                </div>
                                <br />
                                <Box display={'flex'} justifyContent={'space-around'} width={'auto'} >
                                    <Button>Shipping Address</Button>
                                    <Select id='payment' value={pay} placeholder='Paymeny method' width={'12vw'}
                                        onChange={e => setPay(e.target.value)}
                                    >
                                        <option value='COD'>Cash On Delivery</option>
                                        <option value='Cards'>Credit/Debit Card</option>
                                        <option value="netbanking">Net banking</option>
                                    </Select>
                                </Box>
                                {
                                    pay == 'Cards' ? (
                                        <div class="modal">
                                            <form class="form">
                                                <div class="separator">
                                                    <hr class="line" />
                                                    <p>Pay using Credit/Debit card</p>
                                                    <hr class="line" />
                                                </div>
                                                <div class="credit-card-info--form">
                                                    <div class="input_container">
                                                        <label for="password_field" class="input_label">Card holder full name</label>
                                                        <input id="password_field" class="input_field" type="text" name="input-name" title="Inpit title" placeholder="Enter your full name" />
                                                    </div>
                                                    <div class="input_container">
                                                        <label for="password_field" class="input_label">Card Number</label>
                                                        <input id="password_field" class="input_field" type="number" name="input-name" title="Inpit title" placeholder="0000 0000 0000 0000" />
                                                    </div>
                                                    <div class="input_container">
                                                        <label for="password_field" class="input_label">Expiry Date / CVV</label>
                                                        <div class="split">
                                                            <input id="password_field" class="input_field" type="text" name="input-name" title="Expiry Date" placeholder="01/23" />
                                                            <input id="password_field" class="input_field" type="number" name="cvv" title="CVV" placeholder="CVV" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    ) : (
                                        pay == "netbanking" ? (
                                            <>
                                            <br />
                                            <Select width={'auto'}
                                                placeholder='Select your bank'
                                            >
                                                <option value='BOB'>Bank of Baroda</option>
                                                <option value='AXIS'>Axis Bank</option>
                                                <option value="HDFC">HDFC</option>
                                            </Select>
                                            </>
                                        ) : (<p></p>)
                                    )
                                }
                                <br />
                                <Box textAlign={'center'} justifyContent={'center'} display={'flex'}>
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
                <br />
                <Footer/>
            </ChakraProvider>
        </div >
    )
}

export default Buy
