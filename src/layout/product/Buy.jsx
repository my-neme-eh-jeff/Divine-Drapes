import React, { useEffect, useRef } from 'react'
import { useState } from 'react';
import { Box, ChakraProvider, Heading, SimpleGrid, Image, Button, Select, Input } from '@chakra-ui/react'
import './Upload.css'
import Footer from '../Footer/Footer';
import Navbar from '../Navbar/Navbar';
import {
  Modal,
  ModalOverlay,
  ModalContent,
  ModalHeader,
  ModalFooter,
  ModalBody,
  ModalCloseButton,
  useDisclosure
} from '@chakra-ui/react'
import Address from './Address/Address';
import publicAxios from '../../Axios/publicAxios'
import privateAxios from '../../Axios/privateAxios';
import useAuth from '../../Hooks/useAuth';
import { useParams } from 'react-router-dom';
import { Toast } from '@chakra-ui/react';
import { useToast } from '@chakra-ui/react'
import Loader from '../Loader/Loader'

function Buy() {
  const [body, setBody] = useState([])
  const toast = useToast()
  const { productId } = useParams()
  const prodId = productId.split(':')[1]
  console.log(prodId)
  const [selectedImage, setSelectedImage] = useState(null);
  const fileInputRef = useRef(null);
  const [custText, setCustText] = useState('');
  const { isOpen, onOpen, onClose } = useDisclosure()
  const [pay, setPay] = useState()
  const [loading, setLoading] = useState(false);

  const { auth, setAuth } = useAuth();
  const isLogin = auth?.accessToken;
  console.log(isLogin);


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
    console.log(fileInputRef)
  };

  const getSingleProd = async () => {
    setLoading(true);
    let config = {
      method: 'get',
      maxBodyLength: Infinity,
      url: `https://divine-drapes.onrender.com/product/viewProduct/${prodId}`,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + isLogin
      },
    };

    privateAxios.request(config)
      .then((response) => {
        // alert("hitted")
        console.log(JSON.stringify(response.data));
        setBody([response.data]);
      })
      .catch((error) => {
        console.log(error);
      });

  };

  useEffect(() => {
    getSingleProd()
  }, [])

  const imageUploader = (id) => {
    if (body[0]?.data.photo.isCust) {
      let data = new FormData();
      data.append('files', fileInputRef.current.files[0]);
      // data.append('files', selectedImage);
      data.append('id', id);//here the order id is passed

      let config = {
        method: 'post',
        maxBodyLength: Infinity,
        url: 'https://divine-drapes.onrender.com/user/orderPicture',
        headers: {
          'Authorization': `Bearer ` + isLogin,
        },
        data: data
      };


      privateAxios.request(config)
        .then((response) => {
          console.log(JSON.stringify(response.data));
          toast({
            title: 'Your Post is uploaded',
            description: JSON.stringify(response.data.message),
            status: 'success',
            duration: 2500,
            isClosable: true,
          })
        })
        .catch((error) => {
          console.log(error);
          toast({
            title: 'Image cannot be posted',
            description: error.message,
            status: 'error',
            duration: 2500,
            isClosable: true,
          })
        });
    }
    else {
      alert("No imaage required")
    }
  }



  const placeOrder = () => {
    let data = JSON.stringify({
      "pID": prodId,
      "isCustPhoto": body[0]?.data.photo.isCust,
      "isCustText": body[0]?.data.text.isCust,
      "text": custText,
      "isCustColor": body[0]?.data.color.isCust,
      "paymentStatus": "pending",
      "paymentType": pay
    });

    let config = {
      method: 'post',
      maxBodyLength: Infinity,
      url: 'https://divine-drapes.onrender.com/user/order',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + isLogin,
      },
      data: data
    };

    privateAxios.request(config)
      .then((response) => {
        console.log(JSON.stringify(response.data));
        imageUploader(body[0]?.data._id)
        alert("Placed Successfully")
      })
      .catch((error) => {
        console.log(error);
      });

  }
  return (
    <div>

      <ChakraProvider>
        <Navbar />
        {/* {loading ?
                <div>
                <Loader /> 
                </div> 
                : */}
        <Box className='productbody' >
          <br />
          {/* product name here  */}
          <Heading className='namehere'>{body[0]?.data.category}</Heading>
          <br />
          <Box height={'auto'} className='mainpro'>
            <SimpleGrid
              h='auto'
              w='auto'
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
                <p><Heading fontSize={28} fontWeight={700}>{body[0]?.data.name}</Heading></p>
                <p >{body[0]?.data.description}</p>
                <br />
                <p><Heading fontSize={24} fontWeight={700}>₹ {body[0]?.data.cost.value}</Heading></p>
                <br />
                <div className="image-uploader">
                  <label htmlFor="upload-input" className="upload-label">
                    <span className="upload-text">Upload your customization</span>
                    {
                      body[0]?.data.photo.isCust ? (
                        <input id="upload-input" ref={fileInputRef} type="file" accept="image/*" onChange={handleImageChange} />
                      ) : (
                        <input id="upload-input" ref={fileInputRef} disabled='true' type="file" accept="image/*" onChange={handleImageChange} />
                      )
                    }

                  </label>
                  {selectedImage && <img src={selectedImage} alt="Preview" className="preview-image" />}
                </div>
                <br />
                <Heading fontSize={24} fontWeight={700}>Text Customization</Heading>
                {
                  body[0]?.data.text.isCust ? (<Input value={custText} onChange={e => { setCustText(e.target.value) }} placeholder='Enter your Text' />) : (<Input placeholder='Enter your Text' disabled='true' />)
                }

                <br />
                <Box
                  display={"flex"}
                  justifyContent={"space-around"}
                  width={"auto"}
                >
                  <Button onClick={onOpen}>Shipping Address</Button>
                  <Modal isOpen={isOpen} onClose={onClose}>
                    <ModalOverlay />
                    <ModalContent>
                      <ModalHeader>Shipping Addresses</ModalHeader>
                      <ModalCloseButton />
                      <ModalBody>
                        <Address />
                      </ModalBody>

                      <ModalFooter>
                        <Button colorScheme="blue" mr={3} onClick={onClose}>
                          Close
                        </Button>
                        <Button
                          variant="ghost"
                          backgroundColor={"#F7BC62"}
                          _hover={{ color: "black" }}
                        >
                          Save & proceed
                        </Button>
                      </ModalFooter>
                    </ModalContent>
                  </Modal>
                  <Select
                    id="payment"
                    value={pay}
                    placeholder="Paymeny method"
                    width={"12vw"}
                    onChange={(e) => setPay(e.target.value)}
                  >
                    <option value="cod">Cash On Delivery</option>
                    <option value="card">Credit/Debit Card</option>
                    <option value="net banking">Net banking</option>
                    <option value="UPI">UPI (G-pay , paytm , phonePay)</option>
                  </Select>
                </Box>
                {pay == "card" ? (
                  <div className="modal">
                    <form className="form">
                      <div className="separator">
                        <hr className="line" />
                        <p>Pay using Credit/Debit card</p>
                        <hr className="line" />
                      </div>
                      <div className="credit-card-info--form">
                        <div className="input_container">
                          <label htmlFor="password_field" className="input_label">
                            Card holder full name
                          </label>
                          <input
                            id="password_field"
                            className="input_field"
                            type="text"
                            name="input-name"
                            title="Inpit title"
                            placeholder="Enter your full name"
                          />
                        </div>
                        <div className="input_container">
                          <label htmlFor="password_field" className="input_label">
                            Card Number
                          </label>
                          <input
                            id="password_field"
                            className="input_field"
                            type="number"
                            name="input-name"
                            title="Inpit title"
                            placeholder="0000 0000 0000 0000"
                          />
                        </div>
                        <div className="input_container">
                          <label htmlFor="password_field" className="input_label">
                            Expiry Date / CVV
                          </label>
                          <div className="split">
                            <input
                              id="password_field"
                              className="input_field"
                              type="text"
                              name="input-name"
                              title="Expiry Date"
                              placeholder="01/23"
                            />
                            <input
                              id="password_field"
                              className="input_field"
                              type="number"
                              name="cvv"
                              title="CVV"
                              placeholder="CVV"
                            />
                          </div>
                        </div>
                      </div>
                    </form>
                  </div>
                ) : pay == "net banking" ? (
                  <>
                    <br />
                    <Select width={"auto"} placeholder="Select your bank">
                      <option value="BOB">Bank of Baroda</option>
                      <option value="AXIS">Axis Bank</option>
                      <option value="HDFC">HDFC</option>
                    </Select>
                  </>
                ) : (
                  <p></p>
                )}
                <br />
                <Box
                  textAlign={"center"}
                  justifyContent={"center"}
                  display={"flex"}
                >
                  <Button
                    backgroundColor={"#A01E86"}
                    color={"white"}
                    onClick={placeOrder}
                    _hover={{
                      backgroundColor: "#A01E86",
                      color: "black",
                    }}
                    display={"flex"}
                    justifyContent={"center"}
                  >
                    Buy Now
                  </Button>
                </Box>

                {/* <Box className='Box'>

                                </Box> */}
              </Box>
              {/* <Box className='Box' id='rating'
                                display={'flex'} alignItems={'left'} fontSize={'18px'} fontWeight={700} >
                                <div className="content1">
                                    <div className="star" style={{ color: 'yellow' }}>
                                        <svg stroke="currentColor" fill="currentColor" stroke-width="0" version="1.1" viewBox="0 0 16 16" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M16 6.204l-5.528-0.803-2.472-5.009-2.472 5.009-5.528 0.803 4 3.899-0.944 5.505 4.944-2.599 4.944 2.599-0.944-5.505 4-3.899z"></path></svg>
                                    </div>
                                    <div className="rating" style={{ marginLeft: '8px' }}>4.5</div>
                                </div>
                            </Box> */}
            </SimpleGrid>
          </Box>
        </Box>
        {/* } */}
        <br />
        <Footer />
      </ChakraProvider>
    </div>
  );
}

export default Buy;
