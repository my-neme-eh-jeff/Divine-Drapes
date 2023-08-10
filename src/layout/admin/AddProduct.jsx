import { Center, ChakraProvider, Container, Heading, Stack, VStack, Input, Box, HStack, SimpleGrid, Button, TableContainer, Table, Tbody, Tr, Td, InputGroup, InputRightAddon, Textarea, GridItem, FormControl } from '@chakra-ui/react'
import React, { useEffect, useRef, useState } from 'react'

import useAuth from "../../Hooks/useAuth";
import privateAxios from "../../Axios/privateAxios";
function AddProduct() {
    const [selectedImage, setSelectedImage] = useState(null);
    const [productName, setProductName] = useState()
    const [description, setDescription] = useState()
    const [quantity, setQuantity] = useState()
    const [cost, setCost] = useState()
    const [cust, setCust] = useState()
    const [imageCust, setImageCust] = useState(false)
    const [colorCust, setColorCust] = useState(false)
    const [textCust, setTextCust] = useState(false)
    const fileInputRef = useRef(null);
    const [colorInp, setColorInp] = useState()
    const [colors, setColors] = useState([]);
    const [category, setCategory] = useState()
    const { auth, setAuth } = useAuth();
    const isLogin = auth?.accessToken;
    const handleImageChange = (event) => {
        const file = event.target.files[0];
        console.log(file)
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
    const handleColorAdd = (newColor) => {
        setColors([...colors, newColor]);
        console.log(colors);
    };

    const handleColorEdit = (index, updatedColor) => {
        const newColors = [...colors];
        newColors[index] = updatedColor;
        setColors(newColors);
    };

    const handleColorRemove = (index) => {
        const newColors = colors.filter((_, i) => i !== index);
        setColors(newColors);
    };
    // console.log(cust)
    const addnewprod=()=>{
let data = JSON.stringify({
  "name": productName,
  "description": description,
  "category": category,
  "quantity": quantity,
  "cost": {
    "currency": "INR",
    "value": cost
  },
  "photo": {
    "isCust": imageCust
  },
  "text": {
    "isCust": textCust
  },
  "color": {
    "isCust": colorCust,
    "color": colors
  }
});

let config = {
  method: 'post',
  maxBodyLength: Infinity,
  url: 'https://divine-drapes.onrender.com/admin/addProduct',
  headers: { 
    'Content-Type': 'application/json', 
    'Authorization': 'Bearer '+isLogin
  },
  data : data
};

async function makeRequest() {
  try {
    const response = await privateAxios.request(config);
    console.log((response.data));
    if(response.data.product.photo.isCust==true)
    {
        console.log(response.data.product._id);
        addimagetonewprod(response.data.product._id)
    }
  }
  catch (error) {
    console.log(error);
  }
}

makeRequest();

    }
    const addimagetonewprod=(id)=>{
        console.log("adding photos");
// const FormData = require('form-data');
// const fs = require('fs');
let data = new FormData();
data.append('id', id);
data.append('files',file);

let config = {
  method: 'post',
  maxBodyLength: Infinity,
  url: 'https://divine-drapes.onrender.com/admin/addImages',
  headers: { 
    'Authorization': 'Bearer '+isLogin, 
  },
  data : data
};

async function makeRequest() {
  try {
    const response = await privateAxios.request(config);
    console.log((response.data));
  }
  catch (error) {
    console.log(error);
  }
}

makeRequest();

    }
    return (
        <div>
            <ChakraProvider>
                <Center><Heading>Add Products</Heading></Center>
                <br />
                <Container height={'auto'}
                    border={'1px solid #000'}
                    boxShadow={'2px 5px 6px 2px rgba(0, 0, 0, 0.25), -5px -2px 6px 2px rgba(0, 0, 0, 0.25)'}
                    width={'auto'} >
                    <br />
                    <Stack spacing={6}>
                        <div className="image-uploader">
                            <label htmlFor="upload-input" className="upload-label">
                                <span className="upload-text">Upload your Product Image here</span>
                                <input id="upload-input" ref={fileInputRef} type="file" accept="image/*" onChange={handleImageChange} />
                            </label>
                            {selectedImage && <img src={selectedImage} alt="Preview" className="preview-image" />}
                        </div>
                        <Heading fontSize={24} fontWeight={700}>Product Name</Heading>
                        <Input value={productName} onChange={e => { setProductName(e.target.value);console.log(productName) }} placeholder='Enter your Product Name' />
                        <Input value={category} onChange={e => { setCategory(e.target.value);console.log(category) }} placeholder='Enter the Category' />
                        <Textarea placeholder='Enter description' value={description} onChange={e => { setDescription(e.target.value);console.log(description) }} />
                        <SimpleGrid columns={2} columnGap={3} rowGap={2}>
                            <GridItem colSpan={[2, null, 1]}>
                                <FormControl>
                                    <Input placeholder="Enter Quantity" type='number' value={quantity} onChange={(e) => {setQuantity(e.target.value);console.log(quantity)}}/>
                                </FormControl>
                            </GridItem>
                            <GridItem colSpan={[2, null, 1]}>
                                <FormControl>
                                    <Input placeholder="Enter Cost" type='number' value={cost} onChange={(e) => setCost(e.target.value)}/>
                                </FormControl>
                            </GridItem>
                        </SimpleGrid>
                        <Heading fontSize={24} fontWeight={700}>Customization</Heading>
                        <Box >
                            <div className="containerr">
                                <form>
                                    <SimpleGrid columns={{ md: 2, base: 1 }}>
                                        <label>
                                            <input type="radio" value={'yes'} onChange={e => setCust(e.target.value)} name="radio" />
                                            <span>Yes</span>
                                        </label>
                                        <label>
                                            <input type="radio" value={'no'} onChange={e => setCust(e.target.value)} name="radio" />
                                            <span>No</span>
                                        </label>
                                    </SimpleGrid>
                                    <br />
                                </form>
                            </div>
                        </Box>
                        {
                            cust == 'yes' ? (<>
                                <Heading fontSize={24} fontWeight={700}>Select your Customizations</Heading>
                                <div className="containerr">
                                    <form>
                                        <SimpleGrid columns={{ md: 3, base: 1 }}>
                                            <label>
                                                {/* <input type="radio" value={true} onChange={e => setImageCust(e.target.value)} name="radio" /> */}
                                                <input type="checkbox" checked={imageCust} onChange={e => setImageCust(prevValue => !prevValue)} />
                                                <span>Image</span>
                                            </label>
                                            <label>
                                                {/* <input type="radio" value={true} onChange={e => setColorCust(e.target.value)} name="radio" /> */}
                                                <input type="checkbox" checked={colorCust} onChange={e => setColorCust(prevValue => !prevValue)} />
                                                <span>Color</span>
                                            </label>
                                            <label>
                                                {/* <input type="radio" value={true} onChange={e => setTextCust(e.target.value)} name="radio" /> */}
                                                <input type="checkbox" checked={textCust} onChange={e => setTextCust(prevValue => !prevValue)} />
                                                <span>Text</span>
                                            </label>
                                        </SimpleGrid>
                                        <br />
                                    </form>
                                </div>
                            </>) : (<></>)
                        }
                        {
                            colorCust ? (<>
                                <div>
                                    <h2>Add your colors</h2>
                                    <InputGroup>
                                        <Input value={colorInp} onChange={e => { setColorInp(e.target.value) }} placeholder='Enter your Color Availabe' />
                                        <InputRightAddon><Button onClick={() => handleColorAdd(colorInp)}>Add Color</Button></InputRightAddon>
                                    </InputGroup>
                                    <ul>
                                        <TableContainer>
                                            <Table variant={'simple'}>
                                                <Tbody>
                                                    {colors.map((color, index) => (
                                                        <Tr key={index}>
                                                            <Td fontWeight={800}>{color}</Td>
                                                            <Td><Button onClick={() => handleColorEdit(index, prompt('Enter new color:'))}>Edit</Button></Td>
                                                            <Td><Button onClick={() => handleColorRemove(index)}>Remove</Button></Td>
                                                        </Tr>
                                                    ))}
                                                </Tbody>
                                            </Table>
                                        </TableContainer>

                                    </ul>
                                </div>
                            </>) : (<></>)
                        }
                    </Stack>
                    <br />
                    <Center>
                        <Button width={'400px'} background={'#F7BC62'} _hover={{
                         background:'#F7BC62'
                        }}
                        onClick={addnewprod}
                        >

                            Add Product 
                        </Button>
                    </Center>
                    <br />
                </Container>
            </ChakraProvider>
        </div>
    )
}

export default AddProduct
